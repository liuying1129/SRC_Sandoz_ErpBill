unit UfrmInputPKT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Buttons, ToolWin, DB, ADODB,
  DosMove, Grids, DBGrids,StrUtils,ADOLYGetcode, UADOLYQuery, Menus,
  ActnList,Inifiles,ComObj;

type
  TfrmInputPKT = class(TForm)
    DosMove1: TDosMove;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    lyquery1: TADOLYQuery;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    ComboBox1: TComboBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    BitBtn2: TBitBtn;
    LabeledEdit2: TComboBox;
    LabeledEdit3: TComboBox;
    LabeledEdit16: TLabeledEdit;
    LabeledEdit13: TLabeledEdit;
    ComboBox3: TComboBox;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit15: TLabeledEdit;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    ADOQuery2: TADOQuery;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    LabeledEdit11: TLabeledEdit;
    LabeledEdit12: TLabeledEdit;
    LabeledEdit14: TLabeledEdit;
    LabeledEdit17: TLabeledEdit;
    LabeledEdit18: TLabeledEdit;
    LabeledEdit19: TLabeledEdit;
    Label7: TLabel;
    ComboBox4: TComboBox;
    SpeedButton1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton2: TSpeedButton;
    BitBtn1: TBitBtn;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    ActionList1: TActionList;
    ActAdd_Z: TAction;
    ActSave_Z: TAction;
    ActDel_Z: TAction;
    ActAdd_C: TAction;
    ActSave_C: TAction;
    ActDel_C: TAction;
    LabeledEdit10: TLabeledEdit;
    ComboBox2: TLabeledEdit;
    SpeedButton6: TSpeedButton;
    OpenDialog1: TOpenDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure ADOQuery1AfterScroll(DataSet: TDataSet);
    procedure SpeedButton3Click(Sender: TObject);
    procedure LabeledEdit7KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LabeledEdit4KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure ADOQuery1AfterOpen(DataSet: TDataSet);
    procedure LabeledEdit13KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ADOQuery2AfterScroll(DataSet: TDataSet);
    procedure LabeledEdit9KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LabeledEdit18KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton5Click(Sender: TObject);
    procedure ADOQuery2AfterOpen(DataSet: TDataSet);
    procedure FormDestroy(Sender: TObject);
    procedure LabeledEdit10KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton6Click(Sender: TObject);
  private
    { Private declarations }
    //procedure ReadProfile;
    //procedure WriteProfile;
  public
    { Public declarations }
    procedure UpdateAdoQuery1;
    procedure UpdateAdoQuery2;
    procedure updateEdit;
  end;

//var
function  frmInputPKT: TfrmInputPKT;

implementation

uses UDM;

const
  SelectAsn='select c1.name as 货主名称1z2y3xTABLENAME1T2S3Rc1,'+
                      'z.EXPORDERID as 订单总单ID,z.CREDATE as 制单日期,'+
                      'EXPCOMPANYID as 客户代码,'+
                      'RECEIVEHEAD as 客户名称,ADDRESSEID as 地址ID,RECEIVEADDR as 送货地址,'+
                      'TRANSMODEID as 运输方式,z.ADDINVOICEFLAG as 附发票,'+
                      'SAMELOTFLAG as 同批号,'+//URGENFLAG as 急单,
                      'z.TAXFLAG as 保税,z.MEMO as 总单备注,z.IFSHIFANG AS 释放人,z.SHIFANGTIME as 释放时间,'+
                      'z.unid '+
                      'from INF_INPT_pkt_DTL_Z z '+
                      'left join CommCode c1 on c1.TypeName=''货主'' and c1.id=z.GOODSOWNERID ';

var
  ffrmInputPKT: TfrmInputPKT;
  
  ifnewadd,ifnewadd_dtl:boolean;

{$R *.dfm}

function frmInputPKT: TfrmInputPKT;
begin
  if ffrmInputPKT=nil then ffrmInputPKT:=TfrmInputPKT.Create(application.mainform);
  result:=ffrmInputPKT;
end;

procedure TfrmInputPKT.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmInputPKT=self then ffrmInputPKT:=nil;
end;

procedure TfrmInputPKT.SpeedButton1Click(Sender: TObject);
begin
  if ifnewadd then exit;

  combobox1.Text:='';
  LabeledEdit1.Clear;
  //LabeledEdit2.Clear;
  //LabeledEdit3.Clear;
  LabeledEdit4.Clear;
  LabeledEdit16.Clear;
  LabeledEdit5.Clear;
  LabeledEdit10.Clear;//地址ID
  comboBox2.Clear;//送货地址
  LabeledEdit13.Clear;
//  LabeledEdit14.Clear;
//  DateTimePicker1.DateTime:=now;
//  DateTimePicker2.DateTime:=now;
//  DateTimePicker3.DateTime:=now;
//  DateTimePicker4.DateTime:=now;

  if combobox1.CanFocus then combobox1.SetFocus;

  ifnewadd:=true;
end;

procedure TfrmInputPKT.FormCreate(Sender: TObject);
begin
  ifnewadd:=false;
  ifnewadd_dtl:=false;
  
  SetWindowLong(LabeledEdit12.Handle, GWL_STYLE, GetWindowLong(LabeledEdit12.Handle, GWL_STYLE) or ES_NUMBER);//只能输入数字
  SetWindowLong(LabeledEdit17.Handle, GWL_STYLE, GetWindowLong(LabeledEdit17.Handle, GWL_STYLE) or ES_NUMBER);//只能输入数字
end;

procedure TfrmInputPKT.FormShow(Sender: TObject);
var
  adotemp11:tadoquery;
begin
  //加载ComboBox1
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=dm.ADOConnection1;
  ADOtemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='select * from CommCode where TypeName=''货主'' ';
  adotemp11.Open;
  while not adotemp11.Eof do
  begin
    ComboBox1.Items.Add(adotemp11.fieldbyname('Name').AsString);
    adotemp11.Next;
  end;
  adotemp11.Free;
  //============
  //if ComboBox1.Items.Count>=1 then ComboBox1.ItemIndex:=0;

  //ReadProfile;

  ADOQuery1.Connection:=dm.ADOConnection1;
  ADOQuery2.Connection:=dm.ADOConnection1;

  UpdateAdoQuery1;
  
  LabeledEdit9.Enabled:=not SelFromInvn;
  LabeledEdit18.Enabled:=not SelFromInvn;
end;

procedure TfrmInputPKT.BitBtn2Click(Sender: TObject);
var
  adotemp11,adotemp33,adotemp22:tadoquery;
  sqlstr:string;
  Insert_Identity:integer;
  sGOODSOWNERID:string;
  sIFSHIFANG:string;
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  adotemp33:=tadoquery.Create(nil);
  adotemp33.Connection:=DM.ADOConnection1;
  adotemp33.Close;
  adotemp33.SQL.Clear;
  adotemp33.SQL.Text:='select * from CommCode where TypeName=''货主'' and name=''' + ComboBox1.Text + ''' ';
  adotemp33.Open;
  sGOODSOWNERID:=adotemp33.fieldbyname('ID').AsString;
  adotemp33.Free;

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  if ifNewAdd then //新增
  begin
    ifNewAdd:=false;

    sqlstr:='insert into inf_inpt_pkt_dtl_z (GOODSOWNERID,EXPORDERID,EXPCOMPANYID,ADDINVOICEFLAG,ADDRESSEID,RECEIVEADDR,RECEIVEHEAD,SAMELOTFLAG,TAXFLAG,TRANSMODEID,MEMO) ' +
          ' values (''' + sGOODSOWNERID + ''',''' + LabeledEdit1.Text +
          ''',''' + LabeledEdit4.Text + ''',''' + ifThen(ComboBox3.Text='是','1','0') +
          ''',''' + LabeledEdit10.Text +
          ''',''' + ComboBox2.Text +
          ''','''+LabeledEdit16.Text+''','''+
          ifThen(LabeledEdit2.Text='是','1','0') + ''',''' + ifThen(LabeledEdit3.Text='是','1','0') + ''',''' + LabeledEdit13.Text +
          ''',''' + LabeledEdit5.Text +
          ''')';

    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Add(sqlstr);
    adotemp11.SQL.Add(' SELECT SCOPE_IDENTITY() AS Insert_Identity ');
    //adotemp11.Parameters.ParamByName('PREEXPDATE').Value:=DateTimePicker2.Date ;
    //adotemp11.Parameters.ParamByName('VALIDDATE').Value:=DateTimePicker3.Date ;
    //adotemp11.Parameters.ParamByName('PRODDATE').Value:=DateTimePicker4.Date ;
    adotemp11.Open;
    ADOQuery1.Requery([]);
    Insert_Identity:=adotemp11.fieldbyname('Insert_Identity').AsInteger;
  end else //修改
  begin
    IF AdoQuery1.RecordCount=0 THEN
    BEGIN
      adotemp11.Free;
      SHOWMESSAGE('没有记录供你修改，若要新增，请先点击"新增按钮"！');
      EXIT;
    END;

    Insert_Identity:=ADOQuery1.fieldbyname('Unid').AsInteger;

    adotemp22:=tadoquery.Create(nil);
    adotemp22.Connection:=DM.ADOConnection1;
    adotemp22.Close;
    adotemp22.SQL.Clear;
    adotemp22.SQL.Text:='select * from INF_INPT_pkt_DTL_Z where unid='+inttostr(Insert_Identity);
    adotemp22.Open;
    sIFSHIFANG:=adotemp22.fieldbyname('IFSHIFANG').AsString;
    adotemp22.Free;
    if sIFSHIFANG<>'' then
    begin
      adotemp11.Free;
      MessageDlg('已释放,不能修改!', mtError, [mbYes], 0);
      exit;
    end;    

    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:='update inf_inpt_pkt_dtl_z set GOODSOWNERID=''' + sGOODSOWNERID + ''',EXPORDERID=''' + LabeledEdit1.Text + ''',EXPCOMPANYID=''' + LabeledEdit4.Text +
                 ''',ADDINVOICEFLAG=''' + ifThen(ComboBox3.Text='是','1','0') +
                 ''',ADDRESSEID=''' + LabeledEdit10.Text + 
                 ''',RECEIVEADDR=''' + ComboBox2.Text +
                 ''',RECEIVEHEAD='''+LabeledEdit16.Text +
                 ''',SAMELOTFLAG=''' + ifThen(LabeledEdit2.Text='是','1','0') +
                 ''',TAXFLAG=''' + ifThen(LabeledEdit3.Text='是','1','0') +
                 ''',TRANSMODEID=''' + LabeledEdit13.Text +
                 ''',MEMO=''' + LabeledEdit5.Text +
    '''  Where    Unid='+inttostr(Insert_Identity);
//    adotemp11.Parameters.ParamByName('PREEXPDATE').Value:=DateTimePicker2.Date ;
//    adotemp11.Parameters.ParamByName('VALIDDATE').Value:=DateTimePicker3.Date ;
//    adotemp11.Parameters.ParamByName('PRODDATE').Value:=DateTimePicker4.Date ;
    adotemp11.ExecSQL;
    ADOQuery1.Requery([]);
  end;

  adotemp11.Free;
  AdoQuery1.Locate('Unid',Insert_Identity,[loCaseInsensitive]) ;
end;

procedure TfrmInputPKT.UpdateAdoQuery1;
var
  s1:string;
begin
  s1:=StringReplace(SelectAsn,'1z2y3xTABLENAME1T2S3Rc1','',[rfReplaceAll,rfIgnoreCase]);
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Text:=s1+' where convert(varchar(10),credate,111)=convert(varchar(10),getdate(),111)';
  ADOQuery1.Open;
end;

procedure TfrmInputPKT.updateEdit;
var
  iADDINVOICEFLAG,iTAXFLAG,iSAMELOTFLAG:integer;
begin
  if not AdoQuery1.Active then exit;

  ComboBox1.Text:=AdoQuery1.fieldbyname('货主名称').asstring;
  LabeledEdit1.Text:=AdoQuery1.fieldbyname('订单总单ID').asstring;
  if not trystrtoint(AdoQuery1.fieldbyname('同批号').AsString,iSAMELOTFLAG) then iSAMELOTFLAG:=0;
  LabeledEdit2.ItemIndex:=iSAMELOTFLAG;
  if not trystrtoint(AdoQuery1.fieldbyname('保税').AsString,iTAXFLAG) then iTAXFLAG:=0; 
  LabeledEdit3.ItemIndex:=iTAXFLAG;
  //if not trystrtoint(AdoQuery1.fieldbyname('急单').AsString,iURGENFLAG) then iURGENFLAG:=0;
  //ComboBox2.ItemIndex:=iURGENFLAG;
  if not trystrtoint(AdoQuery1.fieldbyname('附发票').AsString,iADDINVOICEFLAG) then iADDINVOICEFLAG:=0;
  ComboBox3.ItemIndex:=iADDINVOICEFLAG;
  LabeledEdit4.Text:=AdoQuery1.fieldbyname('客户代码').asstring;
  LabeledEdit16.Text:=AdoQuery1.fieldbyname('客户名称').asstring;
  LabeledEdit5.Text:=AdoQuery1.fieldbyname('总单备注').asstring;
  LabeledEdit10.Text:=AdoQuery1.fieldbyname('地址ID').asstring;
  ComboBox2.Text:=AdoQuery1.fieldbyname('送货地址').asstring;
  LabeledEdit13.Text:=AdoQuery1.fieldbyname('运输方式').asstring;

  //DateTimePicker2.Date:=AdoQuery1.fieldbyname('预出货日期').AsDateTime;
end;

procedure TfrmInputPKT.ADOQuery1AfterScroll(DataSet: TDataSet);
begin
  ifnewadd:=false;

  updateEdit;

  UpdateAdoQuery2;
end;

procedure TfrmInputPKT.SpeedButton3Click(Sender: TObject);
var
  adotemp11,adotemp22:tadoquery;
  sIFSHIFANG:string;
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  adotemp22:=tadoquery.Create(nil);
  adotemp22.Connection:=DM.ADOConnection1;
  adotemp22.Close;
  adotemp22.SQL.Clear;
  adotemp22.SQL.Text:='select * from INF_INPT_pkt_DTL_Z where unid='+ADOQuery1.fieldbyname('unid').AsString;
  adotemp22.Open;
  sIFSHIFANG:=adotemp22.fieldbyname('IFSHIFANG').AsString;
  adotemp22.Free;

  if sIFSHIFANG<>'' then
  begin
    MessageDlg('已释放,不能删除!', mtError, [mbYes], 0);
    exit;
  end;

  if (MessageDlg('是否真要删除当前主单记录？', mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then exit;

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='delete from INF_INPT_pkt_DTL_Z where unid=' + ADOQuery1.fieldbyname('unid').AsString;
  adotemp11.ExecSQL;
  adotemp11.Free;

  ADOQuery1.Requery([]);
end;

procedure TfrmInputPKT.LabeledEdit7KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.GetCodePos:=gcNone;
  tmpADOLYGetcode.IfNullGetCode:=false;
  if SelFromInvn then
    tmpADOLYGetcode.OpenStr:='select c1.name as 商品编码,c2.name as 品名规格,c1.Remark as 锁代码,c4.name as 锁名称,'+
    'c1.reserve2 as 批号,c1.reserve as 供应商代码,c3.name as 供应商名称,c1.Reserve5 as 保管帐,c1.Reserve6 as 业务帐 '+
    ' from CommCode c1 '+
    ' left join CommCode c2 on c2.TypeName=''商品资料'' and c1.name=c2.ID '+
    ' left join CommCode c3 on c3.TypeName=''客户资料'' and c1.reserve=c3.ID '+
    ' left join CommCode c4 on c4.TypeName=''货品状态'' and c1.Remark=c4.ID '+
    ' where c1.TypeName=''库存管理'' '
  else tmpADOLYGetcode.OpenStr:='select id as 商品编码,name as 品名规格 from CommCode where TypeName=''商品资料'' ';

  if SelFromInvn then tmpADOLYGetcode.InField:='c1.name,c2.pym'
    else tmpADOLYGetcode.InField:='id,name,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
    LabeledEdit15.Text:=tmpADOLYGetcode.OutValue[1];
    if SelFromInvn then
    begin
      LabeledEdit8.Text:=tmpADOLYGetcode.OutValue[4];
      LabeledEdit9.Text:=tmpADOLYGetcode.OutValue[2];
      LabeledEdit11.Text:=tmpADOLYGetcode.OutValue[3];
      LabeledEdit18.Text:=tmpADOLYGetcode.OutValue[5];
      LabeledEdit19.Text:=tmpADOLYGetcode.OutValue[6];
    end;
  end;
  tmpADOLYGetcode.Free;
end;

procedure TfrmInputPKT.LabeledEdit4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
  adotemp11:tadoquery;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.GetCodePos:=gcNone;
  tmpADOLYGetcode.IfNullGetCode:=false;
  tmpADOLYGetcode.OpenStr:='select id as 客户代码,name as 客户名称 from CommCode where TypeName=''客户资料'' ';
  tmpADOLYGetcode.InField:='id,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
    LabeledEdit16.Text:=tmpADOLYGetcode.OutValue[1];

    //地址start
    adotemp11:=tadoquery.Create(nil);
    adotemp11.Connection:=DM.ADOConnection1;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:='select id,name from CommCode where TypeName=''客户地址'' and Reserve='''+tLabeledEdit(SENDER).Text+''' ';
    adotemp11.Open;
    if adotemp11.RecordCount<=1 then
    begin
      LabeledEdit10.Text:=adotemp11.fieldbyname('id').AsString;
      ComboBox2.Text:=adotemp11.fieldbyname('name').AsString;
    end;
    adotemp11.Free;
    //地址stop
  end;
  tmpADOLYGetcode.Free;
end;

procedure TfrmInputPKT.SpeedButton2Click(Sender: TObject);
var
  Save_Cursor:TCursor;
begin
  lyquery1.Connection:=DM.ADOConnection1;
  lyquery1.SelectString:=SelectAsn;
  if lyquery1.Execute then
  begin
    ADOQuery1.SQL.Text:=lyquery1.ResultSelect;
    Save_Cursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;    { Show hourglass cursor }
    try
      ADOQuery1.Open;
    finally
      Screen.Cursor := Save_Cursor;  { Always restore to normal }
    end;
  end;
end;

procedure TfrmInputPKT.N1Click(Sender: TObject);
var
  adotemp11,adotemp22:tadoquery;
  iUnid:integer;
  sIFSHIFANG:string;
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  iUnid:=ADOQuery1.fieldbyname('unid').AsInteger;

  adotemp22:=tadoquery.Create(nil);
  adotemp22.Connection:=DM.ADOConnection1;
  adotemp22.Close;
  adotemp22.SQL.Clear;
  adotemp22.SQL.Text:='select * from INF_INPT_pkt_DTL_Z where unid='+inttostr(iUnid);
  adotemp22.Open;
  sIFSHIFANG:=adotemp22.fieldbyname('IFSHIFANG').AsString;
  adotemp22.Free;

  if sIFSHIFANG<>'' then exit;

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='update INF_INPT_pkt_DTL_Z set IFSHIFANG='''+operator_name+''',shifangtime=getdate() where unid='+inttostr(iUnid);
  adotemp11.ExecSQL;
  adotemp11.Free;

  ADOQuery1.Requery([]);

  AdoQuery1.Locate('Unid',iUnid,[loCaseInsensitive]) ;
end;

procedure TfrmInputPKT.ADOQuery1AfterOpen(DataSet: TDataSet);
begin
  if not DataSet.Active then exit;
  
  dbgrid1.Columns[0].Width:=80;
  dbgrid1.Columns[1].Width:=70;
  dbgrid1.Columns[2].Width:=73;
  dbgrid1.Columns[3].Width:=70;
  dbgrid1.Columns[4].Width:=120;//客户名称
  dbgrid1.Columns[5].Width:=45;//地址ID
  dbgrid1.Columns[6].Width:=120;//送货地址
  dbgrid1.Columns[7].Width:=55;//运输方式
  dbgrid1.Columns[8].Width:=42;
  dbgrid1.Columns[9].Width:=42;
  dbgrid1.Columns[10].Width:=30;
  dbgrid1.Columns[11].Width:=100;//备注
  dbgrid1.Columns[12].Width:=42;//释放人
  dbgrid1.Columns[13].Width:=73;//释放时间
end;

procedure TfrmInputPKT.LabeledEdit13KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.GetCodePos:=gcNone;
  tmpADOLYGetcode.IfNullGetCode:=false;
  tmpADOLYGetcode.OpenStr:='select id as 运输方式代码,name as 运输方式名称 from CommCode where TypeName=''运输方式'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TfrmInputPKT.SpeedButton4Click(Sender: TObject);
begin
  if ifnewadd_dtl then exit;

  LabeledEdit6.Clear;
  LabeledEdit7.Clear;
  LabeledEdit8.Clear;
  LabeledEdit9.Clear;
  LabeledEdit11.Clear;
  LabeledEdit12.Clear;
  LabeledEdit14.Clear;
  LabeledEdit15.Clear;
  //LabeledEdit17.Clear;//药检份数
  LabeledEdit18.Clear;
  LabeledEdit19.Clear;

  if LabeledEdit6.CanFocus then LabeledEdit6.SetFocus;

  ifnewadd_dtl:=true;
end;

procedure TfrmInputPKT.BitBtn1Click(Sender: TObject);
var
  adotemp11,adotemp33,adotemp22,adotemp444:tadoquery;
  sqlstr:string;
  Insert_Identity:integer;
  sGOODSOWNERID:string;
  sSRCID:string;
  sIFSHIFANG:string;
  iPKUNID:INTEGER;
  sReserve2:string;
  sReserve4:string;
  iCKSL:integer;
  fReserve4:single;
  fQTY:single;
  QTY:string;
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  if not ADOQuery1.Active then exit;
  if ADOQuery1.RecordCount=0 then exit;
  
  iPKUNID:=ADOQuery1.fieldbyname('unid').AsInteger;

  adotemp22:=tadoquery.Create(nil);
  adotemp22.Connection:=DM.ADOConnection1;
  adotemp22.Close;
  adotemp22.SQL.Clear;
  adotemp22.SQL.Text:='select * from INF_INPT_pkt_DTL_Z where unid='+inttostr(iPKUNID);
  adotemp22.Open;
  sGOODSOWNERID:=adotemp22.fieldbyname('GOODSOWNERID').AsString;
  sIFSHIFANG:=adotemp22.fieldbyname('IFSHIFANG').AsString;
  adotemp22.Free;
  if sIFSHIFANG<>'' then
  begin
    MessageDlg('已释放,不能修改!', mtError, [mbYes], 0);
    exit;
  end;

  QTY:=LabeledEdit12.Text;
  if(not trystrtoint(QTY,iCKSL))or(iCKSL<=0)then
  begin
    MessageDlg('数量不正确,请重新输入!', mtError, [mbYes], 0);
    if LabeledEdit12.CanFocus then LabeledEdit12.SetFocus;
    exit;
  end;

  sSRCID:='0';

  adotemp33:=tadoquery.Create(nil);
  adotemp33.Connection:=DM.ADOConnection1;
  adotemp33.Close;
  adotemp33.SQL.Clear;
  adotemp33.SQL.Text:='select * from CommCode where TypeName=''货主'' and id=''' + sGOODSOWNERID + ''' ';
  adotemp33.Open;
  sReserve2 := adotemp33.fieldbyname('reserve2').AsString;
  adotemp33.Free;

  if sReserve2='' then//供应商管理
    sSRCID:=LabeledEdit18.text;

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  if ifNewAdd_dtl then //新增
  begin
    ifNewAdd_dtl:=false;

    adotemp444:=tadoquery.Create(nil);
    adotemp444.Connection:=DM.ADOConnection1;
    adotemp444.Close;
    adotemp444.SQL.Clear;
    adotemp444.SQL.Text:='select * from CommCode where TypeName=''商品资料'' and id=''' + LabeledEdit7.Text + ''' ';
    adotemp444.Open;
    sReserve4:=adotemp444.fieldbyname('reserve4').AsString;
    adotemp444.Free;
    if TryStrtofloat(sReserve4,fReserve4) then//如果有单位转换比
    begin
      fQTY:=iCKSL*fReserve4;
      if trunc(fQTY)<>fQTY then
      begin
        MessageDlg('进行单位转换比运算后数量不为整数!',mtError,[mbOK],0);
        adotemp11.Free;
        exit;
      end;
      QTY:=inttostr(trunc(fQTY));
    end;

    sqlstr:='insert into inf_inpt_pkt_dtl_c (EXPORDERDTLID,GOODSID,LOTNO,GOODSTATUS,QTY,ADDMEDCHECKFLAG,DTLMEMO,INVOICETYPE,PKUNID,SRCID) ' +
          ' values (''' + LabeledEdit6.Text + ''',''' + LabeledEdit7.Text+ ''',''' + LabeledEdit8.Text + ''','''+
          LabeledEdit9.Text+ ''',' + QTY + ',''' + LabeledEdit17.Text + ''',''' + LabeledEdit14.Text+ ''',''' + ifThen(ComboBox4.Text='增值','1','0') + ''',' +
          inttostr(iPKUNID) + ',''' + sSRCID +
          ''')';

    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Add(sqlstr);
    adotemp11.SQL.Add(' SELECT SCOPE_IDENTITY() AS Insert_Identity ');
    adotemp11.Open;
    ADOQuery2.Requery([]);
    Insert_Identity:=adotemp11.fieldbyname('Insert_Identity').AsInteger;
  end else //修改
  begin
    IF AdoQuery2.RecordCount=0 THEN
    BEGIN
      adotemp11.Free;
      SHOWMESSAGE('没有记录供你修改，若要新增，请先点击"新增按钮"！');
      EXIT;
    END;

    Insert_Identity:=ADOQuery2.fieldbyname('Unid').AsInteger;

    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:='update inf_inpt_pkt_dtl_c set EXPORDERDTLID=''' + LabeledEdit6.Text + ''',GOODSID=''' + LabeledEdit7.Text +
                 ''',LOTNO=''' + LabeledEdit8.Text +
                 ''',GOODSTATUS=''' + LabeledEdit9.Text +
                 ''',QTY=' + LabeledEdit12.Text +
                 ',ADDMEDCHECKFLAG=''' + LabeledEdit17.Text +
                 ''',DTLMEMO=''' + LabeledEdit14.Text +
                 ''',INVOICETYPE=''' + ifThen(ComboBox4.Text='增值','1','0') +
                 ''',SRCID=''' + sSRCID +
    '''  Where    Unid='+inttostr(Insert_Identity);
    try
      adotemp11.EXECSql ;
    except
      on E:Exception do
      begin
        MESSAGEDLG('修改记录失败:'+E.Message,mtError,[mbOK],0);
      end;
    end;
    ADOQuery2.Requery([]);
  end;

  adotemp11.Free;
  AdoQuery2.Locate('Unid',Insert_Identity,[loCaseInsensitive]) ;
end;

procedure TfrmInputPKT.ADOQuery2AfterScroll(DataSet: TDataSet);
var
  iINVOICETYPE:integer;
begin
  ifnewadd_dtl:=false;

  LabeledEdit6.Text:=ADOQuery2.fieldbyname('订单细单ID').AsString;
  LabeledEdit7.Text:=ADOQuery2.fieldbyname('货品ID').AsString;
  LabeledEdit8.Text:=ADOQuery2.fieldbyname('批号').AsString;
  LabeledEdit9.Text:=ADOQuery2.fieldbyname('锁代码').AsString;
  LabeledEdit11.Text:=ADOQuery2.fieldbyname('锁名称').AsString;
  LabeledEdit12.Text:=ADOQuery2.fieldbyname('数量').AsString;
  LabeledEdit14.Text:=ADOQuery2.fieldbyname('细单备注').AsString;
  LabeledEdit15.Text:=ADOQuery2.fieldbyname('品名规格').AsString;
  LabeledEdit17.Text:=ADOQuery2.fieldbyname('药检份数').AsString;
  LabeledEdit18.Text:=ADOQuery2.fieldbyname('供应商代码').AsString;
  LabeledEdit19.Text:=ADOQuery2.fieldbyname('供应商名称').AsString;
  
  if not trystrtoint(AdoQuery2.fieldbyname('发票类型').AsString,iINVOICETYPE) then iINVOICETYPE:=0;
  ComboBox4.ItemIndex:=iINVOICETYPE;
end;

procedure TfrmInputPKT.UpdateAdoQuery2;
VAR
  iPKUNID:INTEGER;
begin
  if not ADOQuery1.Active then exit;
  IF ADOQuery1.RecordCount>0 THEN iPKUNID:=ADOQuery1.fieldbyname('unid').AsInteger ELSE iPKUNID:=0;

  ADOQuery2.Close;
  ADOQuery2.SQL.Clear;
  ADOQuery2.SQL.Text:='select EXPORDERDTLID as 订单细单ID,GOODSID as 货品ID,C2.Name AS 品名规格,'+
  'LOTNO as 批号,GOODSTATUS as 锁代码,c4.name as 锁名称,QTY as 数量,'+
  'SRCID as 供应商代码,C3.NAME AS 供应商名称,'+
  'INVOICETYPE as 发票类型,OTCFLAG as OTC,'+
  'ADDMEDCHECKFLAG as 药检份数,DTLMEMO as 细单备注,PKUNID,c.unid '+
  'from INF_INPT_PKT_DTL_C C '+
  'left join CommCode c2 on c2.TypeName=''商品资料'' and c2.id=C.GOODSid '+
  'left join CommCode c3 on c3.TypeName=''客户资料'' and c3.id=C.SRCID '+
  'left join CommCode c4 on c4.TypeName=''货品状态'' and c4.id=C.GOODSTATUS '+
  ' where pkunid='+inttostr(iPKUNID);
  ADOQuery2.Open;
end;

procedure TfrmInputPKT.LabeledEdit9KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.GetCodePos:=gcNone;
  tmpADOLYGetcode.IfNullGetCode:=false;
  tmpADOLYGetcode.OpenStr:='select id as 锁代码,name as 锁名称 from CommCode where TypeName=''货品状态'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
    LabeledEdit11.Text:=tmpADOLYGetcode.OutValue[1];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TfrmInputPKT.LabeledEdit18KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.GetCodePos:=gcNone;
  tmpADOLYGetcode.IfNullGetCode:=false;
  tmpADOLYGetcode.OpenStr:='select id as 客户代码,name as 客户名称 from CommCode where TypeName=''客户资料'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
    LabeledEdit19.Text:=tmpADOLYGetcode.OutValue[1];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TfrmInputPKT.SpeedButton5Click(Sender: TObject);
var
  adotemp11,adotemp22:tadoquery;
  sIFSHIFANG:string;
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  if not ADOQuery1.Active then exit;
  if ADOQuery1.RecordCount=0 then exit;
  
  adotemp22:=tadoquery.Create(nil);
  adotemp22.Connection:=DM.ADOConnection1;
  adotemp22.Close;
  adotemp22.SQL.Clear;
  adotemp22.SQL.Text:='select * from INF_INPT_pkt_DTL_z where unid='+ADOQuery1.fieldbyname('unid').AsString;
  adotemp22.Open;
  sIFSHIFANG:=adotemp22.fieldbyname('IFSHIFANG').AsString;
  adotemp22.Free;
  if sIFSHIFANG<>'' then
  begin
    MessageDlg('已释放,不能修改!', mtError, [mbYes], 0);
    exit;
  end;    
  
  if (MessageDlg('是否真要删除当前明细记录？', mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then exit;

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='delete from INF_INPT_pkt_DTL_c where unid=' + ADOQuery2.fieldbyname('unid').AsString;
  adotemp11.ExecSQL;
  adotemp11.Free;

  ADOQuery2.Requery([]);
end;

procedure TfrmInputPKT.ADOQuery2AfterOpen(DataSet: TDataSet);
begin
  if not DataSet.Active then exit;
  
  dbgrid2.Columns[0].Width:=80;
  dbgrid2.Columns[1].Width:=70;
  dbgrid2.Columns[2].Width:=120;//品名规格
  dbgrid2.Columns[3].Width:=70;
  dbgrid2.Columns[4].Width:=50;
  dbgrid2.Columns[5].Width:=100;//锁名称
  dbgrid2.Columns[6].Width:=50;//数量
  dbgrid2.Columns[7].Width:=70;
  dbgrid2.Columns[8].Width:=120;//供应商名称
  dbgrid2.Columns[9].Width:=60;
  dbgrid2.Columns[10].Width:=30;
  dbgrid2.Columns[11].Width:=60;
  dbgrid2.Columns[12].Width:=120;//备注
end;

{procedure TfrmInputPKT.ReadProfile;
var
  configini:tinifile;
begin
  CONFIGINI:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));

  LabeledEdit17.Text:=CONFIGINI.ReadString('Interface','ADDMEDCHECKFLAG','');

  configini.Free;
end;

procedure TfrmInputPKT.WriteProfile;
var
  ConfigIni:tinifile;
begin
  ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));

  ConfigIni.WriteString('Interface','ADDMEDCHECKFLAG',LabeledEdit17.Text); //记录界面中"付药检份数"

  configini.Free;
end;//}

procedure TfrmInputPKT.FormDestroy(Sender: TObject);
begin
  //WriteProfile;
end;

procedure TfrmInputPKT.LabeledEdit10KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.GetCodePos:=gcNone;
  tmpADOLYGetcode.IfNullGetCode:=false;
  tmpADOLYGetcode.OpenStr:='select id as 地址代码,name as 送货地址 from CommCode where TypeName=''客户地址'' and Reserve='''+LabeledEdit4.Text+''' ';
  tmpADOLYGetcode.InField:='id,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
    ComboBox2.Text:=tmpADOLYGetcode.OutValue[1];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TfrmInputPKT.SpeedButton6Click(Sender: TObject);
var
  GOODSOWNERID,EXPORDERID,EXPCOMPANYID,RECEIVEHEAD,ADDRESSEID,RECEIVEADDR,TRANSMODEID,MEMO:string;

  EXPORDERDTLID,GOODSID,LOTNO,GOODSTATUS,QTY,SRCID,ADDMEDCHECKFLAG,DTLMEMO:string;

  RecNum,ValetudinarianInfoId,RecNum_Valu:integer;
  adotemp11,adotemp22,adotemp33,adotemp44,adotemp55,adotemp333,adotemp444:tadoquery;

  Conn:TADOConnection;

  sReserve2:string;
  sReserve4:string;
  fReserve4:single;
  iQTY:integer;
  fQTY:single;
  sIFSHIFANG:string;
begin
  OpenDialog1.DefaultExt := '.xls';
  OpenDialog1.Filter := 'xls (*.xls)|*.xls';
  if not OpenDialog1.Execute then exit;

  Conn:=TADOConnection.Create(nil);
  Conn.LoginPrompt:=false;
  Conn.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+OpenDialog1.FileName+';Extended Properties="Excel 8.0;HDR=Yes;";Persist Security Info=False';
  //无需创建ODBC
  //不要求运行服务的机器一定要安装Excel
  try
    Conn.Connected:=true;
  except
    on E:Exception do
    begin
      MessageDlg('连接EXCEL失败:'+E.Message,mtError,[mbOK],0);
      Conn.Free;
      exit;
    end;
  end;

  (sender as TSpeedButton).Enabled:=false;

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=Conn;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Add('select * from [Sheet1$]');
  adotemp11.Open;
  while NOT adotemp11.Eof do
  begin
    if adotemp11.FindField('货主ID')<>nil then GOODSOWNERID:=adotemp11.fieldbyname('货主ID').AsString;
    if GOODSOWNERID='' then GOODSOWNERID:='21';
    if adotemp11.FindField('Ref Doc Number')<>nil then EXPORDERID:=adotemp11.fieldbyname('Ref Doc Number').AsString;//订单总单ID
    IF EXPORDERID='' THEN
    begin
      MessageDlg('订单总单ID"Ref Doc Number"不能为空,已中止导入!',mtError,[mbOK],0);
      break;
    end;
    if adotemp11.FindField('Sold-to party')<>nil then EXPCOMPANYID:=adotemp11.fieldbyname('Sold-to party').AsString;//客户代码
    if adotemp11.FindField('Customer Name 1')<>nil then RECEIVEHEAD:=adotemp11.fieldbyname('Customer Name 1').AsString;//客户名称
    if adotemp11.FindField('Ship-to party')<>nil then ADDRESSEID:=adotemp11.fieldbyname('Ship-to party').AsString;//地址ID
    if adotemp11.FindField('Street')<>nil then RECEIVEADDR:=adotemp11.fieldbyname('Street').AsString;//送货地址
    if adotemp11.FindField('Recipient')<>nil then RECEIVEADDR:=RECEIVEADDR+' '+adotemp11.fieldbyname('Recipient').AsString;//联系人、联系电话
    if adotemp11.FindField('Shipping Type')<>nil then TRANSMODEID:=adotemp11.fieldbyname('Shipping Type').AsString;
    //if adotemp11.FindField('Recipient')<>nil then MEMO:=adotemp11.fieldbyname('Recipient').AsString;//总单备注
    if adotemp11.FindField('Item in Material Doc')<>nil then EXPORDERDTLID:=adotemp11.fieldbyname('Item in Material Doc').AsString;//订单细单ID
    if adotemp11.FindField('Material Number')<>nil then GOODSID:=adotemp11.fieldbyname('Material Number').AsString;//货品ID
    if adotemp11.FindField('Batch Number')<>nil then LOTNO:=adotemp11.fieldbyname('Batch Number').AsString;//批号
    if adotemp11.FindField('锁代码')<>nil then GOODSTATUS:=adotemp11.fieldbyname('锁代码').AsString;
    if GOODSTATUS='' then GOODSTATUS:='00';
    if adotemp11.FindField('Qty in Unit of Entry')<>nil then QTY:=adotemp11.fieldbyname('Qty in Unit of Entry').AsString;//数量
    if not trystrtoint(QTY,iQTY) then
    begin
      MessageDlg('订单总单ID"'+EXPORDERID+'"数量不为整数,已中止导入!',mtError,[mbOK],0);
      break;
    end;

    //供应商代码 start
    adotemp333:=tadoquery.Create(nil);
    adotemp333.Connection:=DM.ADOConnection1;
    adotemp333.Close;
    adotemp333.SQL.Clear;
    adotemp333.SQL.Text:='select * from CommCode where TypeName=''货主'' and id=''' + GOODSOWNERID + ''' ';
    adotemp333.Open;
    sReserve2 := adotemp333.fieldbyname('reserve2').AsString;
    adotemp333.Free;

    adotemp444:=tadoquery.Create(nil);
    adotemp444.Connection:=DM.ADOConnection1;
    adotemp444.Close;
    adotemp444.SQL.Clear;
    adotemp444.SQL.Text:='select * from CommCode where TypeName=''商品资料'' and id=''' + GOODSID + ''' ';
    adotemp444.Open;
    if sReserve2='' then//供应商管理
      SRCID := adotemp444.fieldbyname('reserve2').AsString;
    sReserve4:=adotemp444.fieldbyname('reserve4').AsString;
    adotemp444.Free;

    if SRCID='' then SRCID:='0';//SRCID在数据库中是非空字段//不管理到供应商
    //供应商代码 stop

    if TryStrtofloat(sReserve4,fReserve4) then//如果有单位转换比
    begin
      fQTY:=iQTY*fReserve4;
      if trunc(fQTY)<>fQTY then
      begin
        MessageDlg('订单总单ID"'+EXPORDERID+'"进行单位转换比运算后数量不为整数,已中止导入!',mtError,[mbOK],0);
        break;
      end;
      QTY:=inttostr(trunc(fQTY));
    end;

    if adotemp11.FindField('药检份数')<>nil then ADDMEDCHECKFLAG:=adotemp11.fieldbyname('药检份数').AsString;
    if ADDMEDCHECKFLAG='' then ADDMEDCHECKFLAG:='1';
    if adotemp11.FindField('细单备注')<>nil then DTLMEMO:=adotemp11.fieldbyname('细单备注').AsString;

    //判断是否存在指定的订单总单ID start
    adotemp22:=tadoquery.create(nil);
    adotemp22.Connection:=dm.ADOConnection1;
    adotemp22.Close;
    adotemp22.SQL.Clear;
    adotemp22.SQL.Text:='select unid,IFSHIFANG from INF_INPT_PKT_DTL_Z where EXPORDERID='''+EXPORDERID+''' ';
    adotemp22.Open;
    RecNum:=adotemp22.RecordCount;
    IF RecNum>=1 then
    begin
      ValetudinarianInfoId:=adotemp22.FIELDBYNAME('UNID').AsInteger;
      sIFSHIFANG:=adotemp22.fieldbyname('IFSHIFANG').AsString;
    end
    else begin
      adotemp55:=tadoquery.create(nil);
      adotemp55.Connection:=dm.ADOConnection1;
      adotemp55.Close;
      adotemp55.SQL.Clear;
      adotemp55.SQL.Add('insert into inf_inpt_pkt_dtl_z (GOODSOWNERID,EXPORDERID,EXPCOMPANYID,ADDINVOICEFLAG,ADDRESSEID,RECEIVEADDR,RECEIVEHEAD,SAMELOTFLAG,TAXFLAG,TRANSMODEID,MEMO) ' +
          ' values (''' + GOODSOWNERID + ''',''' + EXPORDERID + 
          ''',''' + EXPCOMPANYID + ''',''' + '1' +
          ''',''' + ADDRESSEID +
          ''',''' + RECEIVEADDR +
          ''','''+RECEIVEHEAD+''','''+
          '1' + ''',''' + '1' + ''',''' + TRANSMODEID +
          ''',''' + MEMO +
          ''')');
      adotemp55.SQL.Add(' SELECT SCOPE_IDENTITY() AS Insert_Identity ');
      try
        adotemp55.Open;
      except
        on E:Exception do
        begin
          MessageDlg('导入总单'+EXPORDERID+'失败:'+E.Message+',已中止导入!',mtError,[mbOK],0);
          adotemp55.Free;
          adotemp22.Free;
          break;
        end;
      end;
      ValetudinarianInfoId:=adotemp55.fieldbyname('Insert_Identity').AsInteger;
      adotemp55.Free;
    end;      
    adotemp22.Free;
    //判断是否存在指定的订单总单ID stop

    adotemp44:=tadoquery.create(nil);
    adotemp44.Connection:=dm.ADOConnection1;
    adotemp44.Close;
    adotemp44.SQL.Clear;
    adotemp44.SQL.Text:='select COUNT(*) AS RecNum_Valu from INF_INPT_PKT_DTL_C where PkUnid='+inttostr(ValetudinarianInfoId)+' and EXPORDERDTLID='''+EXPORDERDTLID+''' ';
    adotemp44.Open;
    RecNum_Valu:=adotemp44.fieldbyname('RecNum_Valu').AsInteger;
    adotemp44.Free;
    IF RecNum_Valu>0 THEN MessageDlg('订单总单ID"'+EXPORDERID+'",细单ID"'+EXPORDERDTLID+'"已存在,按确定继续!',MTINFORMATION,[mbOK],0);
    IF RecNum_Valu<=0 THEN
    BEGIN
      if sIFSHIFANG<>'' then
      begin
        MessageDlg('订单总单ID"'+EXPORDERID+'"已释放,不能再增加细单ID"'+EXPORDERDTLID+'",按确定继续!',mtError,[mbOK],0);
        adotemp11.Next;
        continue;
      end;

      adotemp33:=tadoquery.create(nil);
      adotemp33.Connection:=dm.ADOConnection1;
      adotemp33.Close;
      adotemp33.SQL.Clear;
      adotemp33.SQL.Add('insert into inf_inpt_pkt_dtl_c (EXPORDERDTLID,GOODSID,LOTNO,GOODSTATUS,QTY,ADDMEDCHECKFLAG,DTLMEMO,INVOICETYPE,PKUNID,SRCID) ' +
                        ' values (''' + EXPORDERDTLID + ''',''' + GOODSID+ ''',''' + LOTNO + ''','''+
                        GOODSTATUS+ ''',' + QTY+ ',''' + ADDMEDCHECKFLAG + ''',''' + DTLMEMO+ ''',''' +'1'+ ''',' +
                        inttostr(ValetudinarianInfoId) + ',''' + SRCID +
                        ''')');
      try
        adotemp33.ExecSQL;
      except
        on E:Exception do
        begin
          MessageDlg('导入明细'+EXPORDERDTLID+'失败:'+E.Message+',已中止导入!',mtError,[mbOK],0);
          adotemp33.Free;
          break;
        end;
      end;
      adotemp33.Free;
    END;

    adotemp11.Next;
  end;

  adotemp11.Free;

  Conn.Free;

  UpdateAdoQuery1;//刷新主界面
  //MESSAGEDLG('导入完成!',MTINFORMATION,[MBOK],0);

  (sender as TSpeedButton).Enabled:=true;
end;

initialization
  ffrmInputPKT:=nil;

end.
