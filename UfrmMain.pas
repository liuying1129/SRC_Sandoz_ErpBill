unit UfrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, ToolWin, Buttons,ShellAPI,StrUtils, DB, ADODB,Inifiles;

//==Ϊ��ͨ��������Ϣ����������״̬��������==//
const
  WM_UPDATETEXTSTATUS=WM_USER+1;
TYPE
  TWMUpdateTextStatus=TWMSetText;
//=========================================//

type
  TfrmMain = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    N8: TMenuItem;
    N10: TMenuItem;
    StatusBar1: TStatusBar;
    N11: TMenuItem;
    N12: TMenuItem;
    N9: TMenuItem;
    N13: TMenuItem;
    procedure N2Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure N13Click(Sender: TObject);
  private
    { Private declarations }
    //==Ϊ��ͨ��������Ϣ����������״̬��������==//
    procedure WMUpdateTextStatus(var message:twmupdatetextstatus);  {WM_UPDATETEXTSTATUS��Ϣ������}
                                              message WM_UPDATETEXTSTATUS;
    procedure updatestatusBar(const text:string);//TextΪ�ø�ʽ#$2+'0:abc'+#$2+'1:def'��ʾ״̬����0����ʾabc,��1����ʾdef,��������
    //==========================================//
    procedure LoadToolMenu(const ToolMenuItem: TMenuItem; const ASel: string);
    procedure miToolItemClick(Sender: TObject);
    procedure ReadIni;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses UfrmCommCode, UfrmInputASN, UfrmInputPKT, UfrmLogin,UDM, Ufrmdocset;

{$R *.dfm}

procedure TfrmMain.N2Click(Sender: TObject);
begin
  application.Terminate;
end;

procedure TfrmMain.N7Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;
  frmCommCode.ShowModal;
end;

procedure TfrmMain.N4Click(Sender: TObject);
begin
  frmInputASN.ShowModal;
end;

procedure TfrmMain.N5Click(Sender: TObject);
begin
  frmInputPKT.ShowModal;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  adotemp22:tadoquery;
  pInStr,pDeStr:Pchar;
  i:integer;
begin
  frmLogin.ShowModal;

  //��ϵͳ����
  adotemp22:=tadoquery.Create(nil);
  adotemp22.Connection:=dm.ADOConnection1;
  adotemp22.Close;
  adotemp22.SQL.Clear;
  adotemp22.SQL.Text:='select Name from CommCode where TypeName=''ϵͳ����'' and ReMark=''��Ȩʹ�õ�λ'' ';
  adotemp22.Open;
  SCSYDW:=adotemp22.fieldbyname('Name').AsString;
  adotemp22.Free;
  if SCSYDW='' then SCSYDW:='2F3A054F64394BBBE3D81033FDE12313';//'δ��Ȩ��λ'���ܺ���ַ���
  //======����SCSYDW
  pInStr:=pchar(SCSYDW);
  pDeStr:=DeCryptStr(pInStr,CryptStr);
  setlength(SCSYDW,length(pDeStr));
  for i :=1  to length(pDeStr) do SCSYDW[i]:=pDeStr[i-1];
  //==========
  
  UpdateStatusBar(#$2+'6:'+SCSYDW);
  
  LoadToolMenu(N8,'select name from CommCode where TypeName=''���߲˵�'' order by ID');

  ReadIni;
end;

procedure TfrmMain.N10Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;
  frmdocset.showmodal;
end;

procedure TfrmMain.N11Click(Sender: TObject);
begin
  frmLogin.ShowModal;
end;

procedure TfrmMain.updatestatusBar(const text: string);
//TextΪ�ø�ʽ#$2+'0:abc'+#$2+'1:def'��ʾ״̬����0����ʾabc,��1����ʾdef,��������
var
  i,J2Pos,J2Len,TextLen,j:integer;
  tmpText:string;
begin
  TextLen:=length(text);
  for i :=0 to StatusBar1.Panels.Count-1 do
  begin
    J2Pos:=pos(#$2+inttostr(i)+':',text);
    J2Len:=length(#$2+inttostr(i)+':');
    if J2Pos<>0 then
    begin
      tmpText:=text;
      tmpText:=copy(tmpText,J2Pos+J2Len,TextLen-J2Pos-J2Len+1);
      j:=pos(#$2,tmpText);
      if j<>0 then tmpText:=leftstr(tmpText,j-1);
      StatusBar1.Panels[i].Text:=tmpText;
    end;
  end;
end;

procedure TfrmMain.WMUpdateTextStatus(var message: twmupdatetextstatus);
begin
  UpdateStatusBar(pchar(message.Text));
  message.Result:=-1;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
//
end;

procedure TfrmMain.LoadToolMenu(const ToolMenuItem: TMenuItem;
  const ASel: string);
var
  adotemp3:tadoquery;
  delMenuItem,TempMenuItem:TMenuItem;
  tempstr:string;
  i,j:integer;
begin
  adotemp3:=tadoquery.Create(nil);
  adotemp3.Connection:=DM.ADOConnection1;
  adotemp3.Close;
  adotemp3.SQL.Clear;
  adotemp3.SQL.Text:=ASel;
  adotemp3.Open;

  //����ǰ��������߲˵���
  for j := ToolMenuItem.Count-1 downto 0 do
  begin
      if (ToolMenuItem.Items[j] is TMenuItem)then
      begin
        delMenuItem := ToolMenuItem.Items[j];
        if (delMenuItem <> nil) then FreeandNIl(delMenuItem);
      end;
  end;

  i:=0;
  while not adotemp3.Eof do
  begin
    inc(i);
    tempstr:=trim(adotemp3.fieldbyname('name').AsString);

    //���ص����߲˵�
    TempMenuItem := TMenuItem.Create(self);
    TempMenuItem.Name := 'TmpTool' + inttostr(i);
    TempMenuItem.Caption := tempstr;
    TempMenuItem.OnClick:=miToolItemClick;
    ToolMenuItem.Add(TempMenuItem);

    adotemp3.Next;
  end;
  adotemp3.Free;
end;

procedure TfrmMain.miToolItemClick(Sender: TObject);
var
  adotemp3:tadoquery;
  Reserve,Reserve2:string;
begin
  adotemp3:=tadoquery.Create(nil);
  adotemp3.Connection:=DM.ADOConnection1;
  adotemp3.Close;
  adotemp3.SQL.Clear;
  adotemp3.SQL.Text:='select Reserve,Reserve2 from CommCode where TypeName=''���߲˵�'' and name='''+(Sender as TMenuItem).Caption+''' ';
  adotemp3.Open;
  Reserve:=adotemp3.fieldbyname('Reserve').AsString;
  Reserve2:=adotemp3.fieldbyname('Reserve2').AsString;
  adotemp3.Free;

  if Reserve2='1' then if not ifhaspower(sender,powerstr_js_main) then exit;

  if ShellExecute(Handle, 'Open', Pchar(ExtractFilePath(application.ExeName)+Reserve), '', '', SW_ShowNormal)<=32 then
    MessageDlg((Sender as TMenuItem).Caption+'('+Reserve+')��ʧ��!',mtError,[mbOK],0);
end;

procedure TfrmMain.N13Click(Sender: TObject);
var                                                                           
  ss:string;
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  ss:='�ֹ��Ƶ��ӿ��ѡȡ��Ʒ'+#2+'CheckListBox'+#2+#2+'1'+#2+#2+#3;
  if ShowOptionForm('ѡ��','ѡ��',Pchar(ss),Pchar(ChangeFileExt(Application.ExeName,'.ini'))) then
	  ReadIni;
end;

procedure TfrmMain.ReadIni;
var
  configini:tinifile;
begin
  CONFIGINI:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));

  SelFromInvn:=configini.ReadBool('ѡ��','�ֹ��Ƶ��ӿ��ѡȡ��Ʒ',false);
      
  configini.Free;
end;

end.
