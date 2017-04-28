unit Ufrmdocset;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls,  ExtCtrls, 
  Grids, DBGrids,  DBCtrls, DB, ADODB,
  ActnList, DosMove, Buttons, ULYDataToExcel;

type
  Tfrmdocset = class(TForm)
    DataSourcedeptlist: TDataSource;
    ADOdeptlist: TADOQuery;
    ADOdoclist: TADOQuery;
    DataSourcedoclist: TDataSource;
    ActionList1: TActionList;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action5: TAction;
    DosMove1: TDosMove;
    LYDataToExcel1: TLYDataToExcel;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    Label1: TLabel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    Panel1: TPanel;
    suiButton1: TSpeedButton;
    suiButton2: TSpeedButton;
    suiButton3: TSpeedButton;
    DBLookupComboBox1: TDBLookupComboBox;
    BitBtn1: TBitBtn;
    procedure DBLookupComboBox1Click(Sender: TObject);
    procedure suiButton1Click(Sender: TObject);
    procedure suiButton2Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure suiButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ADOdoclistAfterScroll(DataSet: TDataSet);
    procedure suiButton2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);

  private
    procedure docrefresh;
    { Private declarations }
  public
    { Public declarations }
  end;

function frmdocset: Tfrmdocset;
//var

implementation
uses  UDM;
const
  sqlstr=' SELECT  id AS 用户代码, name AS 用户名称, pinyin AS 英文名, unid AS 唯一编号'+
         ' FROM worker where pkdeptid=:P_pkdeptid order by id';
var
  ifdocnewadd:boolean;
  ffrmdocset: Tfrmdocset;


{$R *.dfm}

function frmdocset: Tfrmdocset;
begin
  if ffrmdocset=nil then ffrmdocset:=Tfrmdocset.Create(application.mainform);
  result:=ffrmdocset;
end;

procedure Tfrmdocset.DBLookupComboBox1Click(Sender: TObject);
begin
  if (not ADOdeptlist.Active) or(ADOdeptlist.RecordCount=0) then exit;

    ADOdoclist.Close;
    ADOdoclist.Parameters.ParamByName('P_pkdeptid').Value:=ADOdeptlist.fieldbyname('唯一编号').AsInteger;
    ADOdoclist.Open;
    docrefresh;
  
end;

procedure Tfrmdocset.suiButton1Click(Sender: TObject);
begin
      if not ADOdoclist.Active then exit;
      LabeledEdit1.Clear;
      LabeledEdit2.Clear;
      LabeledEdit1.SetFocus;
      ADOdoclist.Edit;
      ADOdoclist.Append;
      ifdocnewadd:=true;
end;

procedure Tfrmdocset.suiButton2Click(Sender: TObject);
Var
   adotemp11,adotemp12: tadoquery;
   iid:string;
    //WBM,PYM:string;
    //pName,pWBM,pPYM:Pchar;
    //i:integer;
Begin
          //pName:=pchar(trim(LabeledEdit2.Text));
          //pWBM:=GETBM(pName,1);
          //pPYM:=GETBM(pName,3);
          //setlength(WBM,length(pWBM));
          //for i :=1  to length(pWBM) do WBM[i]:=pWBM[i-1];
          //setlength(PYM,length(pPYM));
          //for i :=1  to length(pPYM) do PYM[i]:=pPYM[i-1];

   if ifdocnewadd then
   begin
        ifdocnewadd:=false;
        
        if (trim(LabeledEdit1.Text)='') {or (trim(LabeledEdit2.Text)='')} then
              begin showmessage('用户代码不能为空！'); exit; end;

        adotemp12:=tadoquery.Create(nil);
        adotemp12.Connection:=DM.ADOConnection1;
        adotemp12.Close;
        adotemp12.SQL.Clear;
        adotemp12.SQL.Text:='select * from worker ';
        adotemp12.Open;
        if (adotemp12.Locate('id',trim(LabeledEdit1.text),[loCaseInsensitive]) {or adotemp12.Locate('name',trim(LabeledEdit2.text),[loCaseInsensitive])})
            then begin showmessage('已存在该用户代码/用户名称，请更换！'); adotemp12.Free; exit; end;
        adotemp12.Close;
        adotemp12.SQL.Clear;
        adotemp12.SQL.Text:='Insert into WORKER ('+
                            ' Name,PassWd,account_limit,pkdeptid,ID) values ('+
                            ':P_Name,:P_PassWd,:P_account_limit,:P_pkdeptid,:P_ID) ';
        adotemp12.Parameters.ParamByName('P_Name').Value:=trim(uppercase(LabeledEdit2.Text)) ;
        //adotemp12.Parameters.ParamByName('PINYIN').Value:=PYM ;
        //adotemp12.Parameters.ParamByName('WBM').Value:=WBM ;
        adotemp12.Parameters.ParamByName('P_PassWd').Value:='' ;
        adotemp12.Parameters.ParamByName('P_account_limit').Value:='' ;
        adotemp12.Parameters.ParamByName('P_pkdeptid').Value:=ADOdeptlist.FieldByName('唯一编号').AsInteger; ;
        adotemp12.Parameters.ParamByName('P_ID').Value:=trim(uppercase(LabeledEdit1.Text)) ;
        adotemp12.ExecSQL;
        adotemp12.Free;
        iid:=trim(LabeledEdit1.Text);
        ADOdoclist.Close;
        ADOdoclist.Open;
        ADOdoclist.Locate('用户代码',iid,[loCaseInsensitive]);
        exit;
   end else
   begin
        adotemp11:=tadoquery.Create(nil);
        adotemp11.Connection:=DM.ADOConnection1;
        adotemp11.Close;
        adotemp11.SQL.Clear;
        adotemp11.SQL.Text:='update worker set id=:id,name=:name '+
                            'where unid=:unid';
        try
        adotemp11.Parameters.ParamByName('id').Value:=trim(uppercase(LabeledEdit1.Text));
        adotemp11.Parameters.ParamByName('name').Value:=trim(uppercase(LabeledEdit2.Text));
        adotemp11.Parameters.ParamByName('unid').Value:=ADOdoclist.FieldByName('唯一编号').AsInteger;
        //adotemp11.Parameters.ParamByName('PINYIN').Value:=PYM ;
        //adotemp11.Parameters.ParamByName('WBM').Value:=WBM ;
        adotemp11.ExecSQL;
        except
        showmessage('已存在该用户代码或用户代码为空，请更换！');
        adotemp11.Free;
        exit;
        end;
        adotemp11.Free;
        ADOdoclist.Refresh;
   end;

end;

procedure Tfrmdocset.docrefresh;
begin
        ifdocnewadd:=false;
        if (ADOdoclist.Active) and (ADOdoclist.RecordCount>0) then
        begin
            LabeledEdit1.Text:=trim(ADOdoclist.FieldByName('用户代码').AsString);
            LabeledEdit2.Text:=trim(ADOdoclist.FieldByName('用户名称').AsString);
        end else
        begin
            LabeledEdit1.Clear;
            LabeledEdit2.Clear;
        end;
end;

procedure Tfrmdocset.DBGrid1CellClick(Column: TColumn);
begin
      docrefresh;
end;

procedure Tfrmdocset.suiButton3Click(Sender: TObject);
begin
    if not ADOdoclist.Active then exit;
    if ADOdoclist.RecordCount=0 then exit;
    if application.MessageBox('你将删除选定的记录,继续吗?','系统提示', MB_OKCANCEL+MB_ICONWARNING)=1  then
    begin
    ADOdoclist.Delete;
    ADOdoclist.Refresh;
    end;
end;

procedure Tfrmdocset.FormCreate(Sender: TObject);
begin
  ADOdeptlist.Connection:=DM.ADOConnection1;
  ADOdoclist.Connection:=DM.ADOConnection1;

  ChangeYouFormAllControlIme(Self);//设置中文输入法
end;

procedure Tfrmdocset.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmdocset=self then ffrmdocset:=nil;
end;

procedure Tfrmdocset.ADOdoclistAfterScroll(DataSet: TDataSet);
begin
      docrefresh;
end;

procedure Tfrmdocset.suiButton2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then suiButton2Click(nil);
end;

procedure Tfrmdocset.FormShow(Sender: TObject);
begin
    ifdocnewadd:=false;
    ADOdeptlist.Close;
    ADOdeptlist.Open;
    ActionList1.Actions[0].OnExecute:=suiButton1Click;
    ActionList1.Actions[1].OnExecute:=suiButton2Click;
    ActionList1.Actions[2].OnExecute:=suiButton3Click;
    DBLookupComboBox1.KeyField:='科室名称';

    if DBLookupComboBox1.Text='' then
         SendKeyToControl(VK_DOWN,DBLookupComboBox1);

    ADOdoclist.Close;
    ADOdoclist.SQL.Clear;
    ADOdoclist.SQL.Text:=sqlstr;
    ADOdoclist.Parameters.ParamByName('P_pkdeptid').Value:=ADOdeptlist.fieldbyname('唯一编号').AsInteger;
    ADOdoclist.Open;
    docrefresh;
end;

procedure Tfrmdocset.BitBtn1Click(Sender: TObject);
var
  adotemp11:tadoquery;
begin
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='dbo.pro_PrintDepartWorker';
  adotemp11.Open;

  LYDataToExcel1.DataSet:=adotemp11;
  LYDataToExcel1.ExcelTitel:='部门人员';
  LYDataToExcel1.Execute;
  
  adotemp11.Free;
end;

initialization
  ffrmdocset:=nil;

end.
