unit USendToPT;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  ExtCtrls, DB, ADODB,inifiles,ActiveX{CoInitialize},registry, LYTray,DateUtils,
  Menus,VclZip;

type
  //SendToPT��Ϊ������
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

//��дNT�������New->Service Application

//��װ��������������ִ��:Insert_Fph2Rdmx.exe /install
//ж�ط�������������ִ��:Insert_Fph2Rdmx.exe /uninstall

procedure SetDescription(const AClassName:string;const ADescription:string);
//���ӷ�������
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

  //���schema.ini��һ��������
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
  adotemp11.SQL.Text:='select * from commcode where typename=''������ļ�����'' ';
  try
    adotemp11.Open;
  except
    on E:Exception do
    begin
      LogMessage(Name+'��ͨ�ô���"������ļ�����"ʧ��:'+E.Message,EVENTLOG_ERROR_TYPE	);//��WINDOWS�¼��鿴���������Ϣ
      adotemp11.Free;
      Conn_ErpBill.Free;
      Timer1.Enabled:=true;
      exit;
    end;
  end;
  while not adotemp11.Eof do
  begin
    sExpDir:=adotemp11.fieldbyname('reserve2').AsString;
    //�ж��ļ���Ŀ��·���Ƿ����
    IF sExpDir='' THEN sExpDir:='C:\';
    if sExpDir[length(sExpDir)]<>'\' then sExpDir:=sExpDir+'\';
    if not DirectoryExists(sExpDir) then
    begin
      LogMessage('Ŀ¼'+sExpDir+'������,����������',EVENTLOG_ERROR_TYPE	);
      adotemp11.Next;
      continue;
    end;
    //==========================

    sViewName:=adotemp11.fieldbyname('remark').AsString;
    //�жϸ���ͼ�Ƿ��м�¼
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
        LogMessage(Name+'��ѯ��ͼ'+sViewName+'��¼����ʧ��:'+E.Message,EVENTLOG_ERROR_TYPE	);//��WINDOWS�¼��鿴���������Ϣ
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

    sTime:=formatdatetime('YYYYMMDDHHNNSS',NOW);//���ܵ��뵽�Ѵ��ڵ�txt�����򱨴�

    //����schema.ini
    CONFIGINI:=TINIFILE.Create(sExpDir+'schema.ini');
    CONFIGINI.WriteString(sPreFileName+sTime+'.txt','Format','TabDelimited');//�ֶμ���Tab�ָ�
    CONFIGINI.WriteString(sPreFileName+sTime+'.txt','TextDelimiter','None');//�ı������ֶ�ֵû��˫����
    CONFIGINI.WriteString(sPreFileName+sTime+'.txt','ColNameHeader','False');//���ֶ�����
    CONFIGINI.Free;
    //==============

    //�����ļ�
    Conn_Text:=TADOConnection.Create(nil);
    Conn_Text.LoginPrompt:=false;
    Conn_Text.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+sExpDir+';Extended Properties="text;HDR=NO;";Persist Security Info=False';
    try
      Conn_Text.Execute('SELECT * into '+sPreFileName+sTime+'.txt'+' FROM '+sViewName+' IN [ODBC][ODBC;Driver=SQL Server;UID='+suserid+';PWD='+spassword+';Server='+sdatasource+';DataBase='+sinitialcatalog+';]');//���贴��ODBC
    except
      on E:Exception do
      begin
        LogMessage(Name+'����������ļ�ʧ��:'+E.Message,EVENTLOG_ERROR_TYPE	);//��WINDOWS�¼��鿴���������Ϣ
        Conn_Text.Free;
        adotemp11.Next;
        continue;
      end;
    end;
    Conn_Text.Free;
    //=========

    //�������ϴ���־
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
        LogMessage(Name+'�������ϴ���־ʧ��:'+E.Message,EVENTLOG_ERROR_TYPE	);//��WINDOWS�¼��鿴���������Ϣ
      end;
    end;
    adotemp22.Free;
    //==============

    //ѹ���ļ�
    vclzip1:=TVCLZip.create(nil);
    vclzip1.ZipName:=sExpDir+sPreFileName+sTime+'.zip';
    vclzip1.RecreateDirs:=true; //ע������
    vclzip1.StorePaths:=false;
    vclzip1.FilesList.Add(sExpDir+sPreFileName+sTime+'.txt');
    vclzip1.Recurse := True;
    try
      vclzip1.Zip;
    except
      on E:Exception do
      begin
        LogMessage(Name+'ѹ��������ļ�ʧ��('+sPreFileName+sTime+'.txt):'+E.Message,EVENTLOG_ERROR_TYPE	);//��WINDOWS�¼��鿴���������Ϣ
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
  SetDescription(Name,'��������������ļ�');
end;

procedure TSendToPT.ReadIni;
var
  configini:tinifile;
begin
  CONFIGINI:=TINIFILE.Create(ChangeFileExt(AppPath,'.ini'));
  sdatasource := configini.ReadString('�������ݿ�', '������', '');
  sinitialcatalog := configini.ReadString('�������ݿ�', '���ݿ�', '');
  suserid := configini.ReadString('�������ݿ�', '�û�', '');
  spassword := configini.ReadString('�������ݿ�', '����', '');
  configini.Free;
end;

procedure TSendToPT.N1Click(Sender: TObject);
var
  ss:string;
begin
    ss:='������'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '���ݿ�'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '�û�'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '����'+#2+'Edit'+#2+#2+'0'+#2+#2+#3;

  if ShowOptionForm('','����',Pchar(ss),Pchar(ChangeFileExt(AppPath,'.ini'))) then
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

  LYTray1.Hint:=Name+'����';
end;

end.
