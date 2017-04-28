unit UReadFromPT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  ExtCtrls, DB, ADODB,inifiles,ActiveX{CoInitialize},registry, LYTray,DateUtils,
  Menus,VclZip;

type
  //ReadFromPT即为服务名
  TReadFromPT = class(TService)
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
  ReadFromPT: TReadFromPT;

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
  ReadFromPT.Controller(CtrlCode);
end;

function TReadFromPT.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TReadFromPT.ServiceStart(Sender: TService; var Started: Boolean);
begin
  ReadIni;

  Timer1.Interval:=60*1000;
  Timer1.Enabled:=true;
end;

procedure TReadFromPT.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  Timer1.Enabled:=false;
end;

procedure TReadFromPT.Timer1Timer(Sender: TObject);
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
  i,j:integer;
  iRecNum:integer;

  VclZip1:TVCLZip;
  sr: TSearchRec;
  sl:tstrings;
begin
  Timer1.Enabled:=false;

  {//清除schema.ini的一部分内容
  lsSection:=Tstringlist.Create;
  CONFIGINI:=TINIFILE.Create(sExpDir+'schema.ini');
  CONFIGINI.ReadSections(lsSection);
  for i :=0  to lsSection.Count-1 do
  begin
    if pos(FormatDateTime('YYYYMMDD',now),lsSection[i])<=0 then CONFIGINI.EraseSection(lsSection[i]);
  end;
  CONFIGINI.Free;
  lsSection.Free;
  //==========================}  

  Conn_ErpBill:=TADOConnection.Create(nil);
  Conn_ErpBill.LoginPrompt:=false;
  Conn_ErpBill.ConnectionString:='Provider=SQLOLEDB.1;Data Source='+sdatasource+';Initial Catalog='+sinitialcatalog+';user id='+sUserID+';password='+sPassword+';';

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=Conn_ErpBill;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='select * from commcode where typename=''平台反馈文件导入'' ';
  adotemp11.Open;
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
    {//判断该视图是否有记录
    adotemp33:=tadoquery.Create(nil);
    adotemp33.Connection:=Conn_ErpBill;
    adotemp33.Close;
    adotemp33.SQL.Clear;
    adotemp33.SQL.Text:='select count(*) as iRecNum from '+sViewName;
    adotemp33.Open;
    iRecNum:=adotemp33.fieldbyname('iRecNum').AsInteger;
    adotemp33.Free;
    if iRecNum<=0 then
    begin
      adotemp11.Next;
      continue;
    end;
    //====================}

    sPreFileName:=adotemp11.fieldbyname('reserve1').AsString;

    sl:=tstringlist.Create;
    if FindFirst(sExpDir+sPreFileName+'*.txt', faAnyFile, sr) = 0 then
    begin
      sl.Add(sr.Name);
      while FindNext(sr) = 0 do sl.Add(sr.Name);
      FindClose(SR);
    end;

    for j :=0  to sl.Count-1 do
    begin
      //导入文件
      TRY
        Conn_ErpBill.Execute('Select * Into '+sViewName+' From [Text;Database='+sExpDir+'].'+sl[j]);
      except
        on E:Exception do
        begin
          LogMessage(Name+'导入反馈文件失败:'+E.Message,EVENTLOG_ERROR_TYPE	);//向WINDOWS事件查看器中添加消息
          continue;
        end;
      end;
      //=========

      //导入后删除文件
      if fileexists(sExpDir+sl[j]) then deletefile(sExpDir+sl[j]);
      //==============
    end;
    sl.Free;


    {sSpName:=adotemp11.fieldbyname('name').AsString;

    sTime:=formatdatetime('YYYYMMDDHHNNSS',NOW);//不能导入到已存在的txt，否则报错

    //配置schema.ini
    CONFIGINI:=TINIFILE.Create(sExpDir+'schema.ini');
    CONFIGINI.WriteString(sPreFileName+sTime+'.txt','Format','TabDelimited');//字段间用Tab分隔
    CONFIGINI.WriteString(sPreFileName+sTime+'.txt','TextDelimiter','None');//文本类型字段值没有双引号
    CONFIGINI.WriteString(sPreFileName+sTime+'.txt','ColNameHeader','False');//无字段名称
    CONFIGINI.Free;
    //==============}

    {//压缩文件
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
    //========}

    adotemp11.Next;
  end;

  adotemp11.Free;
  Conn_ErpBill.Free;

  Timer1.Enabled:=true;
end;

procedure TReadFromPT.ServiceAfterInstall(Sender: TService);
begin
  SetDescription(Name,'解析平台反馈文件');
end;

procedure TReadFromPT.ReadIni;
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

procedure TReadFromPT.N1Click(Sender: TObject);
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

procedure TReadFromPT.ServiceCreate(Sender: TObject);
var
  buf: array[0..MAX_PATH] of Char;
  hinst: HMODULE;
begin
  hinst:=GetModuleHandle('ProReadFromPT.exe');
  GetModuleFileName(hinst,buf,MAX_PATH);
  AppPath:=strpas(buf);

  LYTray1.Hint:=Name+'设置';
end;

end.
