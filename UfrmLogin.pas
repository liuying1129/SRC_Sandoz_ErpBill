unit UfrmLogin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, DB, DBTables, DBCtrls, Grids,
  DBGrids, ADODB, DosMove,inifiles, ActnList, jpeg,IdIPWatch;

type
  TfrmLogin = class(TForm)
    ADOQuery1: TADOQuery;
    DosMove1: TDosMove;
    ActionList1: TActionList;
    Action1: TAction;
    suiForm1: TPanel;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    suiButton1: TBitBtn;
    suiButton2: TBitBtn;
    suiButton3: TBitBtn;
    suiButton4: TBitBtn;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LabeledEdit4Exit(Sender: TObject);
    procedure suiButton1Click(Sender: TObject);
    procedure suiButton2Click(Sender: TObject);
    procedure suiButton3Click(Sender: TObject);
    procedure suiButton3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure suiButton4Click(Sender: TObject);
    
  private
    { Private declarations }
    maySavePass:boolean;
    PROCEDURE MODIFY_PASS_COMP_VISIBLE_FALSE;
    PROCEDURE MODIFY_PASS_COMP_VISIBLE_TRUE;
  public
    { Public declarations }
  end;

//var
function  frmLogin: TfrmLogin;

implementation
uses  UDM, UfrmMain;

var
  ffrmLogin: TfrmLogin;
  powerstr_js:string;

{$R *.dfm}

////////////////////////////////////////////////////////////////////////////////
function  frmLogin: TfrmLogin;        {��̬�������庯��}
begin
  if ffrmLogin=nil then ffrmLogin:=TfrmLogin.Create(application.mainform);
  result:=ffrmLogin;
end;

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmLogin=self then ffrmLogin:=nil;
end;
////////////////////////////////////////////////////////////////////////////////

procedure TfrmLogin.BitBtn2Click(Sender: TObject);
begin
  application.Terminate;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  ADOQuery1.Connection:=DM.ADOConnection1;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
var
  ini:tinifile;
begin
  ini:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
  Label1.Caption:='��Ȩ����:'+ini.ReadString('Interface','companyname','');//�㶫�������������
  Label2.Caption:='��ϵ�绰:'+ini.ReadString('Interface','companytel','');//13710248644
  ini.Free;
  if FileExists(ExtractFilePath(application.ExeName)+'logo.bmp') then
    Image1.Picture.LoadFromFile(ExtractFilePath(application.ExeName)+'logo.bmp')
    else if FileExists(ExtractFilePath(application.ExeName)+'logo.jpg') then
      Image1.Picture.LoadFromFile(ExtractFilePath(application.ExeName)+'logo.jpg')
      else Image1.Picture:=nil;

  LabeledEdit2.Clear;
  MODIFY_PASS_COMP_VISIBLE_FALSE;
end;

procedure TfrmLogin.MODIFY_PASS_COMP_VISIBLE_FALSE;
begin
  LabeledEdit1.Visible:=false;
  LabeledEdit3.Visible:=false;
  maySavePass:=false;
end;

procedure TfrmLogin.MODIFY_PASS_COMP_VISIBLE_TRUE;
begin
  LabeledEdit1.Visible:=true;
  LabeledEdit3.Visible:=true;
  maySavePass:=true;
end;

procedure TfrmLogin.BitBtn3Click(Sender: TObject);
var
  pwd_old,PWD_OLDfromDB:STRING;
begin
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Text:='select * from worker';
  ADOQuery1.Open;

  if not ADOQuery1.Locate('id',LabeledEdit4.Text,[loCaseInsensitive]) then
  begin
    messagedlg('�޴��û�',mtError,[mbok],0);
    exit;
  end;

  //===========�ж�ԭ�����Ƿ���ȷ=====================================
  PWD_old:=trim(uppercase(LabeledEdit2.Text));

  PWD_OLDfromDB:=ADOQuery1.fieldbyname('passwd').AsString;

  if uppercase(trim(PWD_old))<>uppercase(TRIM(PWD_OLDfromDB)) then
  begin
      messagedlg('���벻��ȷ��',mtInformation,[mbok],0);
      LabeledEdit2.SetFocus;
     exit;
  end ;
  //====================================================================

  MODIFY_PASS_COMP_VISIBLE_TRUE ;
end;

procedure TfrmLogin.BitBtn4Click(Sender: TObject);
var
  PWD:STRING;
begin
  if not maySavePass then exit;

  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Text:='select * from worker';
  ADOQuery1.Open;

  if trim(LabeledEdit1.Text)='' then
  begin
     messagedlg('�޸ĺ�����벻��Ϊ�գ�',mtInformation,[mbok],0);
     exit;
  end;

  if(trim(LabeledEdit1.Text)<>trim(LabeledEdit3.Text)) then
  begin
     messagedlg('����ȷ�ϴ���',mtInformation,[mbok],0);
     exit;
  end;

  PWD:=trim(uppercase(LabeledEdit1.Text));  

  ADOQuery1.Locate('id',trim(LabeledEdit4.Text),[loCaseInsensitive]);
  ADOQuery1.Edit;
  ADOQuery1.FieldByName('passwd').AsString:=pwd;
  ADOQuery1.Post;
  MODIFY_PASS_COMP_VISIBLE_FALSE;

  messagedlg('�����޸ĳɹ���',mtInformation,[mbok],0);
  LabeledEdit2.SetFocus;
end;

procedure TfrmLogin.LabeledEdit4Exit(Sender: TObject);
begin
    ADOQuery1.Close;
    ADOQuery1.SQL.Clear;
    ADOQuery1.SQL.Text:='select * from worker ';
    ADOQuery1.Open;

    if not ADOQuery1.Locate('id',LabeledEdit4.Text,[loCaseInsensitive]) then
    begin
      LABELEDEDIT5.Text:='';
      //messagedlg('�޴��û�',mtError,[mbok],0);
      exit;
    end;
    LABELEDEDIT5.Text:=TRIM(ADOQuery1.FIELDBYNAME('NAME').AsString);

end;

procedure TfrmLogin.suiButton1Click(Sender: TObject);
var
  pwd_old,PWD_OLDfromDB:STRING;
begin
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Text:='select * from worker ';
  ADOQuery1.Open;

  if not ADOQuery1.Locate('id',LabeledEdit4.Text,[loCaseInsensitive]) then
  begin
    messagedlg('�޴��û�',mtError,[mbok],0);
    exit;
  end;


  //===========�ж�ԭ�����Ƿ���ȷ=====================================
  PWD_old:=trim(uppercase(LabeledEdit2.Text));

  PWD_OLDfromDB:=ADOQuery1.fieldbyname('passwd').AsString;

  if uppercase(trim(PWD_old))<>uppercase(TRIM(PWD_OLDfromDB)) then
  begin
      messagedlg('���벻��ȷ��',mtInformation,[mbok],0);
      LabeledEdit2.SetFocus;
     exit;
  end ;
  //====================================================================
  MODIFY_PASS_COMP_VISIBLE_TRUE ;
end;

procedure TfrmLogin.suiButton2Click(Sender: TObject);
var
  PWD:STRING;
begin
  if not maySavePass then exit;

  if trim(LabeledEdit1.Text)='' then
  begin
     messagedlg('�޸ĺ�����벻��Ϊ�գ�',mtInformation,[mbok],0);
     exit;
  end;

  if(trim(LabeledEdit1.Text)<>trim(LabeledEdit3.Text)) then
  begin
     messagedlg('����ȷ�ϴ���',mtInformation,[mbok],0);
     exit;
  end;

  PWD:=trim(uppercase(LabeledEdit1.Text));

  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Text:='select * from worker';
  ADOQuery1.Open;

  if ADOQuery1.Locate('id',trim(LabeledEdit4.Text),[loCaseInsensitive]) then
  begin
  ADOQuery1.Edit;
  ADOQuery1.FieldByName('passwd').AsString:=pwd;
  ADOQuery1.Post;
  end;

  LabeledEdit1.Clear;
  LabeledEdit3.Clear;
  MODIFY_PASS_COMP_VISIBLE_FALSE;
  messagedlg('�����޸ĳɹ���',mtInformation,[mbok],0);
  LabeledEdit2.SetFocus;
end;

procedure TfrmLogin.suiButton3Click(Sender: TObject);
var
  PWD,PWDfromDB:STRING;
  IdIPWatch:TIdIPWatch;
  sLocalIP,sLocalName:string;
begin
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Text:='select * from worker ';
  ADOQuery1.Open;

  if not ADOQuery1.Locate('id',LabeledEdit4.Text,[loCaseInsensitive]) then
  begin
    messagedlg('�޴��û�',mtError,[mbok],0);
    exit;
  end;

  PWD:=trim(uppercase(LabeledEdit2.Text));

  PWDfromDB:=ADOQuery1.fieldbyname('passwd').AsString;

  if uppercase(trim(PWD))<>uppercase(TRIM(PWDfromDB)) then
  begin
    messagedlg('�������',mtError,[mbok],0);
    LabeledEdit2.SetFocus;

    IdIPWatch:=TIdIPWatch.Create(nil);
    IdIPWatch.HistoryEnabled:=false;
    sLocalIP:=IdIPWatch.LocalIP;
    sLocalName:=IdIPWatch.LocalName;
    IdIPWatch.Free;
    ExecSQLCmd(LisConn,'insert into AppVisit (IP,UserName,ActionName,ActionTime,Reserve4,ComputerName) values ('''+sLocalIP+''','''+LabeledEdit4.Text+''',''��¼'',getdate(),''��¼ʧ��,�������'','''+sLocalName+''')');
  end
  else   //�ɹ���¼
  begin
    close;
    powerstr_js:=ADOQuery1.fieldbyname('account_limit').AsString;
    powerstr_js_main:=powerstr_js;
    operator_name:=trim(labelededit5.Text);
    operator_id:=trim(labelededit4.Text);
    SendNotifyMessage(application.mainform.handle,WM_UPDATETEXTSTATUS,0,integer(pchar(#$2+'2:'+operator_id+#$2+'4:'+operator_name)));
    
    IdIPWatch:=TIdIPWatch.Create(nil);
    IdIPWatch.HistoryEnabled:=false;
    sLocalIP:=IdIPWatch.LocalIP;
    sLocalName:=IdIPWatch.LocalName;
    IdIPWatch.Free;
    ExecSQLCmd(LisConn,'insert into AppVisit (IP,UserName,ActionName,ActionTime,Reserve4,ComputerName) values ('''+sLocalIP+''','''+operator_name+''',''��¼'',getdate(),''��¼�ɹ�'','''+sLocalName+''')');
  end;
end;

procedure TfrmLogin.suiButton3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=13 then suiButton3Click(nil);
end;

procedure TfrmLogin.suiButton4Click(Sender: TObject);
begin
  application.Terminate;
end;

initialization
  ffrmLogin:=nil;

end.
