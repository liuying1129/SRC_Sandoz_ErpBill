unit UDM;

interface

uses
  SysUtils, Classes, DB, ADODB,Inifiles,Forms{Application变量},Menus,ComCtrls,
  StdCtrls,ExtCtrls,Buttons,Dialogs,Controls,Windows,DBGrids,DBCtrls,Mask,
  IdBaseComponent, IdComponent, IdIPWatch;

type
  TDM = class(TDataModule)
    ADOConnection1: TADOConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  CryptStr='lc';//加解密种子
  SYSNAME='ERPBILL';
  sDBALIAS='ALIAS_SHHJ';
	BASE_URL='http://211.97.0.5:8080/YkAPI/service';

var
  DM: TDM;
  
  LisConn:string;//Lis连接字符串,MakeDBConn过程中被赋值
  powerstr_js_main:string;
  operator_name:string;
  operator_id:string;
  SCSYDW:string;
  SelFromInvn:boolean;
  gsLocalIP:string;
  gsLocalName:string;

function DeCryptStr(aStr: Pchar; aKey: Pchar): Pchar;stdcall;external 'DESCrypt.dll';//解密
function EnCryptStr(aStr: Pchar; aKey: Pchar): Pchar;stdcall;external 'DESCrypt.dll';//加密
function ShowOptionForm(const pCaption,pTabSheetCaption,pItemInfo,pInifile:Pchar):boolean;stdcall;external 'OptionSetForm.dll';
//加强型的Pos函数,取得psubStr在pAllstr中第Times次出现的位置
function PosExt(const psubStr,pAllstr:Pchar;const Times:Byte):integer;stdcall;external 'LYFunction.dll';
  
function ifhaspower(sender: tobject;const powerstr_js:string): boolean;
function MakeDBConn:boolean;
procedure LoadGroupName(const comboBox:TcomboBox;const ASel:string);
procedure SendKeyToControl(const VK:byte;control:Twincontrol);
Procedure ChangeYouFormAllControlIme(YFormName:TWinControl);//需要更改输入法的窗体名称
function ExecSQLCmd(AConnectionString:string;ASQL:string):integer;

implementation

{$R *.dfm}

procedure SendKeyToControl(const VK:byte;control:Twincontrol);
BEGIN
  control.SetFocus;
  keybd_event(VK,MapVirtualKey(VK,0),0,0); //指定键被按下
END;

function haspower(powerstr_cur, menuname,sDatabaseName: string): boolean;
var
  jsmc:string;
  plusPos:integer;
  aa,bb:string;
  menuname_js:string;
  ADOquery_ryjs,ADOquery_menuitem:tADOquery;
  user_powerstr:string;
  ado_super:tadoquery;
begin
  result:=false;
  //===============超级用户例外=================//
  ado_super:=tadoquery.Create(nil);
  ado_super.Connection:=DM.ADOConnection1;
  ado_super.SQL.Clear;
  ado_super.SQL.Text:='select * from worker where ifSuperUser=''1'' ';
  ado_super.Open;
  ado_super.First;
  if ado_super.Locate('id',operator_id,[loCaseInsensitive]) then
  begin
    result:=true;
    ado_super.Free;
    exit;
  end;
  //=======================================================//
  aa:='';bb:='';
  user_powerstr:=powerstr_cur;

  ADOquery_ryjs:=tADOquery.Create(nil);
  ADOquery_ryjs.Connection:=DM.ADOConnection1;
  ADOquery_ryjs.SQL.Clear;
  ADOquery_ryjs.SQL.Text:='select * from ryjs';
  ADOquery_ryjs.Open;

  ADOquery_menuitem:=tADOquery.Create(nil);
  ADOquery_menuitem.Connection:=DM.ADOConnection1;
  ADOquery_menuitem.SQL.Clear;
  ADOquery_menuitem.SQL.Text:='select * from menuitem WHERE SYSNAME='''+SYSNAME+''' ';
  ADOquery_menuitem.Open;

  while length(user_powerstr)>=3 do
  begin
    plusPos:=posExt('+',Pchar(user_powerstr),2);
    jsmc:=copy(user_powerstr,2,pluspos-2);
    try
      aa:=aa+ADOquery_ryjs.Lookup('jsmc',jsmc,'jsqx');
    except
      aa:=aa+'';
    end;
    delete(user_powerstr,1,pluspos);
  end;

  while length(aa)>=3 do
  begin
    bb:=copy(aa,1,3);
    if ADOquery_menuitem.Locate('bm',bb,[loCaseInsensitive]) then
        menuname_js:=trim(ADOquery_menuitem.fieldbyname('menuname').AsString)
    else  menuname_js:='';

    if  UpperCase(menuname_js)= UpperCase(Trim(menuname)) then
    begin
      result:=true;
      ADOquery_ryjs.Free;
      ADOquery_menuitem.Free;
      exit;
    end;
    delete(aa,1,3);
  end;

  if ADOquery_ryjs<>nil then ADOquery_ryjs.Free;
  if ADOquery_menuitem<>nil then ADOquery_menuitem.Free;
  if ado_super<>nil then ado_super.Free;
end;

function ifhaspower(sender: tobject;const powerstr_js:string): boolean;
begin
  result:=true;

  if sender is tmenuitem then
  begin
    if not haspower(powerstr_js,tmenuitem(sender).Caption,sDBALIAS) then result:=false;
  end;

  if sender is ttoolbutton then
  begin
    if not haspower(powerstr_js,ttoolbutton(sender).Caption,sDBALIAS) then result:=false;
  end;

  if sender is tbutton then
  begin
    if not haspower(powerstr_js,tbutton(sender).Caption,sDBALIAS) then result:=false;
  end;

  if sender is tpanel then
  begin
    if not haspower(powerstr_js,tpanel(sender).Caption,sDBALIAS) then result:=false;
  end;

  if sender is tspeedbutton then
  begin
    if not haspower(powerstr_js,tspeedbutton(sender).Caption,sDBALIAS) then result:=false;
  end;//}

  if sender is tcombobox then  
  begin
    if not haspower(powerstr_js,inttostr(tcombobox(sender).tag),sDBALIAS) then result:=false;
  end;

  if sender is tedit then
  begin
    if not haspower(powerstr_js,inttostr(tedit(sender).tag),sDBALIAS) then result:=false;
  end;

  if sender is tLabeledEdit then
  begin
    if not haspower(powerstr_js,tLabeledEdit(sender).EditLabel.Caption,sDBALIAS) then result:=false;
  end;

  if not result then
      messagedlg('对不起，您没有该权限！',mtinformation,[mbok],0);
end;

function MakeDBConn:boolean;
var
  newconnstr,ss: string;
  Ini: tinifile;
  userid, password, datasource, initialcatalog: string;{, provider}
  ifIntegrated:boolean;//是否集成登录模式

  pInStr,pDeStr:Pchar;
  i:integer;
  Label labReadIni;
begin
  result:=false;

  labReadIni:
  Ini := tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  datasource := Ini.ReadString('连接数据库', '服务器', '');
  initialcatalog := Ini.ReadString('连接数据库', '数据库', '');
  ifIntegrated:=ini.ReadBool('连接数据库','集成登录模式',false);
  userid := Ini.ReadString('连接数据库', '用户', '');
  password := Ini.ReadString('连接数据库', '口令', '107DFC967CDCFAAF');
  Ini.Free;
  //======解密password
  pInStr:=pchar(password);
  pDeStr:=DeCryptStr(pInStr,CryptStr);
  setlength(password,length(pDeStr));
  for i :=1  to length(pDeStr) do password[i]:=pDeStr[i-1];
  //==========

  newconnstr := '';
  newconnstr := newconnstr + 'user id=' + UserID + ';';
  newconnstr := newconnstr + 'password=' + Password + ';';
  newconnstr := newconnstr + 'data source=' + datasource + ';';
  newconnstr := newconnstr + 'Initial Catalog=' + initialcatalog + ';';
  newconnstr := newconnstr + 'provider=' + 'SQLOLEDB.1' + ';';
  //Persist Security Info,表示ADO在数据库连接成功后是否保存密码信息
  //ADO缺省为True,ADO.net缺省为False
  //程序中会传ADOConnection信息给TADOLYQuery,故设置为True
  newconnstr := newconnstr + 'Persist Security Info=True;';
  if ifIntegrated then
    newconnstr := newconnstr + 'Integrated Security=SSPI;';
  try
    dm.ADOConnection1.Connected := false;
    dm.ADOConnection1.ConnectionString := newconnstr;
    dm.ADOConnection1.Connected := true;
    result:=true;
    LisConn:=newconnstr;
  except
  end;
  if not result then
  begin
    ss:='服务器'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '数据库'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '集成登录模式'+#2+'CheckListBox'+#2+#2+'0'+#2+'启用该模式,则用户及口令无需填写'+#2+#3+
        '用户'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '口令'+#2+'Edit'+#2+#2+'0'+#2+#2+'1';
    if ShowOptionForm('连接数据库','连接数据库',Pchar(ss),Pchar(ChangeFileExt(Application.ExeName,'.ini'))) then
      goto labReadIni else application.Terminate;
  end;
end;

procedure LoadGroupName(const comboBox:TcomboBox;const ASel:string);
var
  adotemp3:tadoquery;
  tempstr:string;
begin
     adotemp3:=tadoquery.Create(nil);
     adotemp3.Connection:=DM.ADOConnection1;
     adotemp3.Close;
     adotemp3.SQL.Clear;
     adotemp3.SQL.Text:=ASel;
     adotemp3.Open;
     
     comboBox.Items.Clear;//加载前先清除comboBox项

     while not adotemp3.Eof do
     begin
      tempstr:=trim(adotemp3.Fields[0].AsString);

      comboBox.Items.Add(tempstr); //加载到comboBox

      adotemp3.Next;
     end;
     adotemp3.Free;
end;

Procedure ChangeYouFormAllControlIme(YFormName:TWinControl);//需要更改输入法的窗体名称
//输入法自动切换过程
//20051104 by 刘鹰
//解决思路:
//程序员只需要将窗体中该输入中文的控件的imemode=imOpen,然后在每个窗体里
//create(或active)事件里调用本人编写的方法ChangeYouFormAllControlIme(Self)即可.
//在程序中提供一个用户输入法选项供用户选择自己喜欢的输入法,
//调用显示FrmImeNameList窗体即可!
//注意：在"选择输入法后"要再次调用ChangeYouFormAllControlIme(Self)方法哦:)
var
  StrImeName:string;
  procedure JugeClassType(PClass:Tcontrol);
  //虽然麻烦,但必须具体判断,下面将 dephi可更改的控件几乎都包含了,没有包含的是使用价值不大.
  begin
    if pclass is TEdit then//更改Tedit类控件,以下同理
    begin
      if TEdit(pclass).ImeMode=imOpen then
        TEdit(pclass).ImeName:=StrImeName
      else
        TEdit(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TLabeledEdit then
    begin
      if TLabeledEdit(pclass).ImeMode=imOpen then
        TLabeledEdit(pclass).ImeName:=StrImeName
      else
        TLabeledEdit(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TMemo then
    begin
      if TMemo(pclass).ImeMode=imOpen then
       TMemo(pclass).ImeName:=StrImeName
      else
       TMemo(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TComboBox then
    begin
      if TComboBox(pclass).ImeMode=imOpen then
       TComboBox(pclass).ImeName:=StrImeName
      else
       TComboBox(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TRichEdit then
    begin
      if TRichEdit(pclass).ImeMode=imOpen then
       TRichEdit(pclass).ImeName:=StrImeName
      else
       TRichEdit(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TDBGrid then
    begin
      if TDBGrid(pclass).ImeMode=imOpen then
       TDBGrid(pclass).ImeName:=StrImeName
      else
       TDBGrid(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TDBEdit then
    begin
      if TDBEdit(pclass).ImeMode=imOpen then
       TDBEdit(pclass).ImeName:=StrImeName
      else
       TDBEdit(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TDbMemo then
    begin
      if TDbMemo(pclass).ImeMode=imOpen then
       TDbMemo(pclass).ImeName:=StrImeName
      else
       TDbMemo(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TDbcombobox then
    begin
      if TDbcombobox(pclass).ImeMode=imOpen then
       TDbcombobox(pclass).ImeName:=StrImeName
      else
       TDbcombobox(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is Tdblookupcombobox then
    begin
      if Tdblookupcombobox(pclass).ImeMode=imOpen then
       Tdblookupcombobox(pclass).ImeName:=StrImeName
      else
       Tdblookupcombobox(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is Tdbrichedit then
    begin
      if Tdbrichedit(pclass).ImeMode=imOpen then
       Tdbrichedit(pclass).ImeName:=StrImeName
      else
       Tdbrichedit(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TMaskEdit then
    begin
      if TMaskEdit(pclass).ImeMode=imOpen then
        TMaskEdit(pclass).ImeName:=StrImeName
      else
        TMaskEdit(pclass).ImeMode:=imClose;
      exit;
    end;
  end;
const
  DefaultImeName='中文 (简体) - 智能 ABC';
var
  i:integer;
  ChildControl:TControl;
  ConfigIni:tinifile;
  YouFormOrOTher:Twincontrol;
begin
  YouFormOrOTher:=YFormName;

  //读取保存的用户选择的输入法,用单元全局变量 StrImeName 保存
  //主窗体Create时调用该过程,此时UDM没被创建,故用"ExtractFilePath(application.ExeName)"代替AppPath变量
  ConfigIni:=tinifile.Create(ExtractFilePath(application.ExeName)+'AppProfile.ini');
  try
    StrImeName:=ConfigIni.ReadString('输入法选择','默认中文输入法',DefaultImeName);
  finally
    ConfigIni.Free;
  end;

  //调用方法 JugeClassType(ChildControl) 更改窗体中控件的 ImeMode
  for i:=0 to YouFormOrOTher.ControlCount-1 do
  begin
   ChildControl:=YouFormOrOTher.Controls[i];
   JugeClassType(ChildControl);

   //如果控件包含控件,更改被包含的控件
   if ChildControl is TWinControl then ChangeYouFormAllControlIme(ChildControl as TWinControl);
  end;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
var
  IdIPWatch:TIdIPWatch;
begin
  MakeDBConn;

  IdIPWatch:=TIdIPWatch.Create(nil);
  IdIPWatch.HistoryEnabled:=false;
  gsLocalIP:=IdIPWatch.LocalIP;
  gsLocalName:=IdIPWatch.LocalName;
  IdIPWatch.Free;
end;

function ExecSQLCmd(AConnectionString:string;ASQL:string):integer;
var
  Conn:TADOConnection;
  Qry:TAdoQuery;
begin
  Conn:=TADOConnection.Create(nil);
  Conn.LoginPrompt:=false;
  Conn.ConnectionString:=AConnectionString;
  Qry:=TAdoQuery.Create(nil);
  Qry.Connection:=Conn;
  Qry.Close;
  Qry.SQL.Clear;
  Qry.SQL.Text:=ASQL;
  Try
    Result:=Qry.ExecSQL;
  except
    on E:Exception do
    begin
      MESSAGEDLG('函数ExecSQLCmd失败:'+E.Message+'。错误的SQL:'+ASQL,mtError,[mbOK],0);
      Result:=-1;
    end;
  end;
  Qry.Free;
  Conn.Free;
end;

end.
