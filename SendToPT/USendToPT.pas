unit USendToPT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  ExtCtrls, DB, ADODB,inifiles,ActiveX{CoInitialize},registry, LYTray,DateUtils,
  Menus,VclZip;

type
  //SendToPT即为服务名
  TSendToPT = class(TService)
    Timer1: TTimer;
    ADOConnection1: TADOConnection;
    LYTray1: TLYTray;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure ServiceAfterInstall(Sender: TService);
    procedure N1Click(Sender: TObject);
    procedure ServiceCreate(Sender: TObject);
  private
    { Private declarations }
    procedure ReadIni;
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

var
  SendToPT: TSendToPT;

implementation

var
  AppPath:string;  
  sDatasource :string;
  sInitialcatalog :string;
  sUserid :string;
  sPassword :string;  

{$R *.DFM}

function ShowOptionForm(const pCaption,pTabSheetCaption,pItemInfo,pInifile:Pchar):boolean;stdcall;external 'OptionSetForm.dll';

//编写NT服务程序。New->Service Application

//安装服务，在命令行中执行:Insert_Fph2Rdmx.exe /install
//卸载服务，在命令行中执行:Insert_Fph2Rdmx.exe /uninstall

procedure SetDescription(const AClassName:string;const ADescription:string);
//增加服务描述
var
  vReg:TRegistry;
begin
  vReg:=TRegistry.Create;
  vReg.RootKey:=HKEY_LOCAL_MACHINE;
  vReg.OpenKey('\SYSTEM\CurrentControlSet\Services\'+AClassName,True);
  vReg.WriteString('Description',ADescription);
  vReg.CloseKey;
  vReg.Free;
end;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  SendToPT.Controller(CtrlCode);
end;

function TSendToPT.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TSendToPT.ServiceStart(Sender: TService; var Started: Boolean);
begin
  ReadIni;

  Timer1.Interval:=60*1000;
  Timer1.Enabled:=true;
end;

procedure TSendToPT.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  Timer1.Enabled:=false;
end;

procedure TSendToPT.Timer1Timer(Sender: TObject);
var
  Conn_Text:TADOConnection;
  Conn_ErpBill:TADOConnection;
  
  sTime:string;
  adotemp11,adotemp22,adotemp33:tadoquery;
  sExpDir:string;
  sViewName:string;
  sPreFileName:string;
  sSpName:string;

  CONFIGINI:tinifile;
  lsSection:TStrings;
  i:integer;
  iRecNum:integer;

  VclZip1:TVCLZip;
begin
  Timer1.Enabled:=false;

  //清除schema.ini的一部分内容
  lsSection:=Tstringlist.Create;
  CONFIGINI:=TINIFILE.Create(sExpDir+'schema.ini');
  CONFIGINI.ReadSections(lsSection);
  for i :=0  to lsSection.Count-1 do
  begin
    if pos(FormatDateTime('YYYYMMDD',now),lsSection[i])<=0 then CONFIGINI.EraseSection(lsSection[i]);
  end;
  CONFIGINI.Free;
  lsSection.Free;
  //==========================  

  Conn_ErpBill:=TADOConnection.Create(nil);
  Conn_ErpBill.LoginPrompt:=false;
  Conn_ErpBill.ConnectionString:='Provider=SQLOLEDB.1;Data Source='+sdatasource+';Initial Catalog='+sinitialcatalog+';user id='+sUserID+';password='+sPassword+';';

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=Conn_ErpBill;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='select * from commcode where typename=''出入库文件导出'' ';
  try
    adotemp11.Open;
  except
    on E:Exception do
    begin
      LogMessage(Name+'打开通用代码"出入库文件导出"失败:'+E.Message,EVENTLOG_ERROR_TYPE	);//向WINDOWS事件查看器中添加消息
      adotemp11.Free;
      Conn_ErpBill.Free;
      Timer1.Enabled:=true;
      exit;
    end;
  end;
  while not adotemp11.Eof do
  begin
    sExpDir:=adotemp11.fieldbyname('reserve2').AsString;
    //判断文件的目的路径是否存在
    IF sExpDir='' THEN sExpDir:='C:\';
    if sExpDir[length(sExpDir)]<>'\' then sExpDir:=sExpDir+'\';
    if not DirectoryExists(sExpDir) then
    begin
      LogMessage('目录'+sExpDir+'不存在,请重新设置',EVENTLOG_ERROR_TYPE	);
      adotemp11.Next;
      continue;
    end;
    //==========================

    sViewName:=adotemp11.fieldbyname('remark').AsString;
    //判断该视图是否有记录
    adotemp33:=tadoquery.Create(nil);
    adotemp33.Connection:=Conn_ErpBill;
    adotemp33.Close;
    adotemp33.SQL.Clear;
    adotemp33.SQL.Text:='select count(*) as iRecNum from '+sViewName;
    try
      adotemp33.Open;
    except
      on E:Exception do
      begin
        LogMessage(Name+'查询视图'+sViewName+'记录条数失败:'+E.Message,EVENTLOG_ERROR_TYPE	);//向WINDOWS事件查看器中添加消息
        adotemp33.Free;
        adotemp11.Next;
        continue;
      end;
    end;
    iRecNum:=adotemp33.fieldbyname('iRecNum').AsInteger;
    adotemp33.Free;
    if iRecNum<=0 then
    begin
      adotemp11.Next;
      continue;
    end;
    //====================
    
    sPreFileName:=adotemp11.fieldbyname('reserve').AsString;
    sSpName:=adotemp11.fieldbyname('name').AsString;

    sTime:=formatdatetime('YYYYMMDDHHNNSS',NOW);//不能导入到已存在的txt，否则报错

    //配置schema.ini
    CONFIGINI:=TINIFILE.Create(sExpDir+'schema.ini');
    CONFIGINI.WriteString(sPreFileName+sTime+'.txt','Format','TabDelimited');//字段间用Tab分隔
    CONFIGINI.WriteString(sPreFileName+sTime+'.txt','TextDelimiter','None');//文本类型字段值没有双引号
    CONFIGINI.WriteString(sPreFileName+sTime+'.txt','ColNameHeader','False');//无字段名称
    CONFIGINI.Free;
    //==============

    //导出文件
    Conn_Text:=TADOConnection.Create(nil);
    Conn_Text.LoginPrompt:=false;
    Conn_Text.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+sExpDir+';Extended Properties="text;HDR=NO;";Persist Security Info=False';
    try
      Conn_Text.Execute('SELECT * into '+sPreFileName+sTime+'.txt'+' FROM '+sViewName+' IN [ODBC][ODBC;Driver=SQL Server;UID='+suserid+';PWD='+spassword+';Server='+sdatasource+';DataBase='+sinitialcatalog+';]');//无需创建ODBC
    except
      on E:Exception do
      begin
        LogMessage(Name+'导出出入库文件失败:'+E.Message,EVENTLOG_ERROR_TYPE	);//向WINDOWS事件查看器中添加消息
        Conn_Text.Free;
        adotemp11.Next;
        continue;
      end;
    end;
    Conn_Text.Free;
    //=========

    //更改已上传标志
    adotemp22:=tadoquery.Create(nil);
    adotemp22.Connection:=Conn_ErpBill;
    adotemp22.Close;
    adotemp22.SQL.Clear;
    adotemp22.SQL.Text:=sSpName+' '''+sViewName+''' ';
    try
      adotemp22.ExecSQL;
    except
      on E:Exception do
      begin
        LogMessage(Name+'更改已上传标志失败:'+E.Message,EVENTLOG_ERROR_TYPE	);//向WINDOWS事件查看器中添加消息
      end;
    end;
    adotemp22.Free;
    //==============

    //压缩文件
    vclzip1:=TVCLZip.create(nil);
    vclzip1.ZipName:=sExpDir+sPreFileName+sTime+'.zip';
    vclzip1.RecreateDirs:=true; //注意这里
    vclzip1.StorePaths:=false;
    vclzip1.FilesList.Add(sExpDir+sPreFileName+sTime+'.txt');
    vclzip1.Recurse := True;
    try
      vclzip1.Zip;
    except
      on E:Exception do
      begin
        LogMessage(Name+'压缩出入库文件失败('+sPreFileName+sTime+'.txt):'+E.Message,EVENTLOG_ERROR_TYPE	);//向WINDOWS事件查看器中添加消息
      end;
    end;
    vclzip1.Free;
    //========

    adotemp11.Next;
  end;

  adotemp11.Free;
  Conn_ErpBill.Free;

  Timer1.Enabled:=true;
end;

procedure TSendToPT.ServiceAfterInstall(Sender: TService);
begin
  SetDescription(Name,'货主导出出入库文件');
end;

procedure TSendToPT.ReadIni;
var
  configini:tinifile;
begin
  CONFIGINI:=TINIFILE.Create(ChangeFileExt(AppPath,'.ini'));
  sdatasource := configini.ReadString('连接数据库', '服务器', '');
  sinitialcatalog := configini.ReadString('连接数据库', '数据库', '');
  suserid := configini.ReadString('连接数据库', '用户', '');
  spassword := configini.ReadString('连接数据库', '口令', '');
  configini.Free;
end;

procedure TSendToPT.N1Click(Sender: TObject);
var
  ss:string;
begin
    ss:='服务器'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '数据库'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '用户'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '口令'+#2+'Edit'+#2+#2+'0'+#2+#2+#3;

  if ShowOptionForm('','设置',Pchar(ss),Pchar(ChangeFileExt(AppPath,'.ini'))) then
	  ReadIni;
end;

procedure TSendToPT.ServiceCreate(Sender: TObject);
var
  buf: array[0..MAX_PATH] of Char;
  hinst: HMODULE;
begin
  hinst:=GetModuleHandle('ProSendToPT.exe');
  GetModuleFileName(hinst,buf,MAX_PATH);
  AppPath:=strpas(buf);

  LYTray1.Hint:=Name+'设置';
end;

end.
