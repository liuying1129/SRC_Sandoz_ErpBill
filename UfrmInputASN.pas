unit UfrmInputASN;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Buttons, ToolWin, DB, ADODB,
  DosMove, Grids, DBGrids,StrUtils,ADOLYGetcode, UADOLYQuery, Menus,
  ActnList;

type
  TfrmInputASN = class(TForm)
    Panel1: TPanel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    LabeledEdit11: TLabeledEdit;
    LabeledEdit12: TLabeledEdit;
    BitBtn2: TBitBtn;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    DosMove1: TDosMove;
    ADOQuery1: TADOQuery;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    LabeledEdit2: TComboBox;
    LabeledEdit3: TComboBox;
    Label2: TLabel;
    Label6: TLabel;
    LabeledEdit15: TLabeledEdit;
    LabeledEdit16: TLabeledEdit;
    SpeedButton3: TSpeedButton;
    lyquery1: TADOLYQuery;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    ActionList1: TActionList;
    ActSave: TAction;
    ActDel: TAction;
    ActAdd: TAction;
    Label3: TLabel;
    ComboBox2: TComboBox;
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
  private
    { Private declarations }
  public
    { Public declarations }
    procedure UpdateAdoQuery1;
    procedure updateEdit;
  end;

//var
function  frmInputASN: TfrmInputASN;

implementation

uses UDM;

const
  SelectAsn='select c1.name as ��������1z2y3xTABLENAME1T2S3Rc1,'+
                      'z.PORDERID as �����ܵ�ID,z.CREDATE as �Ƶ�����,'+
                      'z.OPERATIONTYPE as ҵ������,z.IMPORTFLAG as ����,'+
                      'z.TAXFLAG as ��˰,z.MEMO as �ܵ���ע,z.PORDERDTLID as ����ϸ��ID,'+
                      'z.GOODSID as ��ƷID,'+
                      'c2.name as Ʒ�����1z2y3xTABLENAME1T2S3Rc21w2v3uFIELDNAME1T2S3Rname,'+
                      'z.LOTNO as ����,z.APPROVEDOCNO as ��׼�ĺ�,'+
                      'z.QTY as ����,z.SOURCECOMPANYID as ��Ӧ�̴���,'+
                      'c3.name as ��Ӧ������1z2y3xTABLENAME1T2S3Rc31w2v3uFIELDNAME1T2S3Rname,'+
                      'z.DTLMEMO as ϸ����ע,z.IFSHIFANG AS �ͷ���,z.SHIFANGTIME as �ͷ�ʱ��,'+
                      'z.unid '+
                      'from INF_INPT_ASN_DTL_Z z '+
                      'left join CommCode c1 on c1.TypeName=''����'' and c1.id=z.GOODSOWNERID '+
                      'left join CommCode c2 on c2.TypeName=''��Ʒ����'' and c2.id=z.GOODSid '+
                      'left join CommCode c3 on c3.TypeName=''�ͻ�����'' and c3.id=z.SOURCECOMPANYID ';

var
  ffrmInputASN: TfrmInputASN;
  
  ifnewadd:boolean;

{$R *.dfm}

function frmInputASN: TfrmInputASN;
begin
  if ffrmInputASN=nil then ffrmInputASN:=TfrmInputASN.Create(application.mainform);
  result:=ffrmInputASN;
end;

procedure TfrmInputASN.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmInputASN=self then ffrmInputASN:=nil;
end;

procedure TfrmInputASN.SpeedButton1Click(Sender: TObject);
begin
  if ifnewadd then exit;

  combobox1.Text:='';
  LabeledEdit1.Clear;
  //LabeledEdit2.Clear;
  //LabeledEdit3.Clear;
  LabeledEdit4.Clear;
  LabeledEdit16.Clear;
  LabeledEdit5.Clear;
  LabeledEdit6.Clear;
  LabeledEdit7.Clear;
  LabeledEdit15.Clear;
  LabeledEdit8.Clear;
  LabeledEdit9.Clear;
//  LabeledEdit10.Clear;
  LabeledEdit11.Clear;
  LabeledEdit12.Clear;
//  LabeledEdit13.Clear;
//  LabeledEdit14.Clear;
//  DateTimePicker1.DateTime:=now;
//  DateTimePicker2.DateTime:=now;
//  DateTimePicker3.DateTime:=now;
//  DateTimePicker4.DateTime:=now;

  if combobox1.CanFocus then combobox1.SetFocus;
   
  ifnewadd:=true;
end;

procedure TfrmInputASN.FormCreate(Sender: TObject);
begin
  ifnewadd:=false;
  
  SetWindowLong(LabeledEdit11.Handle, GWL_STYLE, GetWindowLong(LabeledEdit11.Handle, GWL_STYLE) or ES_NUMBER);//ֻ����������
//  SetWindowLong(LabeledEdit13.Handle, GWL_STYLE, GetWindowLong(LabeledEdit13.Handle, GWL_STYLE) or ES_NUMBER);//ֻ����������
end;

procedure TfrmInputASN.FormShow(Sender: TObject);
var
  adotemp11:tadoquery;
begin
  //����ComboBox1
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=dm.ADOConnection1;
  ADOtemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='select * from CommCode where TypeName=''����'' ';
  adotemp11.Open;
  while not adotemp11.Eof do
  begin
    ComboBox1.Items.Add(adotemp11.fieldbyname('Name').AsString);
    adotemp11.Next;
  end;
  adotemp11.Free;
  //============
  //if ComboBox1.Items.Count>=1 then ComboBox1.ItemIndex:=0;

  ADOQuery1.Connection:=dm.ADOConnection1;
  
  UpdateAdoQuery1;  
end;

procedure TfrmInputASN.BitBtn2Click(Sender: TObject);
var
  adotemp11,adotemp33,adotemp22:tadoquery;
  sqlstr:string;
  Insert_Identity:integer;
  sComeFlag:STRING;//�Ƿ�Ӧ�̹����־
  sSOURCECOMPANYID:string;//
  sGOODSOWNERID:string;
  sSRCID:string;
  sIFSHIFANG:string;
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  sComeFlag := '0';
  sSRCID:='0';

  adotemp33:=tadoquery.Create(nil);
  adotemp33.Connection:=DM.ADOConnection1;
  adotemp33.Close;
  adotemp33.SQL.Clear;
  adotemp33.SQL.Text:='select * from CommCode where TypeName=''����'' and name=''' + ComboBox1.Text + ''' ';
  adotemp33.Open;
  sGOODSOWNERID:=adotemp33.fieldbyname('ID').AsString;
  sSOURCECOMPANYID := adotemp33.fieldbyname('reserve2').AsString;
  adotemp33.Free;

  if sSOURCECOMPANYID='' then//��Ӧ�̹���
  begin
    sSOURCECOMPANYID:=LabeledEdit4.text;
    sSRCID:=LabeledEdit4.text;
    sComeFlag := '1';
  end;

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  if ifNewAdd then //����
  begin
    ifNewAdd:=false;

    sqlstr:='insert into inf_inpt_ASN_dtl_z (GOODSOWNERID,PORDERID,SOURCECOMPANYID,OPERATIONTYPE,IMPORTFLAG,TAXFLAG,MEMO,PORDERDTLID,GOODSID,LOTNO,APPROVEDOCNO,qty,ComeFlag,dtlmemo,SRCID) ' +
          ' values (''' + sGOODSOWNERID + ''',''' + LabeledEdit1.Text + ''','''+
          sSOURCECOMPANYID + ''',''' + ifThen(ComboBox2.Text='�����˻�','7','1') + ''',''' + ifThen(LabeledEdit2.Text='��','1','0') + ''',''' + ifThen(LabeledEdit3.Text='��','1','0') + ''',''' + LabeledEdit5.Text +
          ''',''' + LabeledEdit6.Text + ''',''' + LabeledEdit7.Text + ''',''' + LabeledEdit8.Text + ''','''+
          LabeledEdit9.Text + ''',' + LabeledEdit11.Text + ',''' + sComeFlag + ''',''' + LabeledEdit12.Text + ''',''' + sSRCID +
          ''')';

    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Add(sqlstr);
    adotemp11.SQL.Add(' SELECT SCOPE_IDENTITY() AS Insert_Identity ');
    //adotemp11.Parameters.ParamByName('ARRIVEDATE').Value:=DateTimePicker2.Date ;
    //adotemp11.Parameters.ParamByName('VALIDDATE').Value:=DateTimePicker3.Date ;
    //adotemp11.Parameters.ParamByName('PRODDATE').Value:=DateTimePicker4.Date ;
    adotemp11.Open;
    ADOQuery1.Requery([]);
    Insert_Identity:=adotemp11.fieldbyname('Insert_Identity').AsInteger;
  end else //�޸�
  begin
    IF AdoQuery1.RecordCount=0 THEN
    BEGIN
      adotemp11.Free;
      SHOWMESSAGE('û�м�¼�����޸ģ���Ҫ���������ȵ��"������ť"��');
      EXIT;
    END;

    Insert_Identity:=ADOQuery1.fieldbyname('Unid').AsInteger;

    adotemp22:=tadoquery.Create(nil);
    adotemp22.Connection:=DM.ADOConnection1;
    adotemp22.Close;
    adotemp22.SQL.Clear;
    adotemp22.SQL.Text:='select * from INF_INPT_asn_DTL_Z where unid='+inttostr(Insert_Identity);
    adotemp22.Open;
    sIFSHIFANG:=adotemp22.fieldbyname('IFSHIFANG').AsString;
    adotemp22.Free;
    if sIFSHIFANG<>'' then
    begin
      adotemp11.Free;
      MessageDlg('���ͷ�,�����޸�!', mtError, [mbYes], 0);
      exit;
    end;    

    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:='update inf_inpt_asn_dtl_z set GOODSOWNERID=''' + sGOODSOWNERID + ''',PORDERID=''' + LabeledEdit1.Text + ''',SOURCECOMPANYID=''' + sSOURCECOMPANYID +''',OPERATIONTYPE=''' + ifThen(ComboBox2.Text='�����˻�','7','1') + 
                 ''',IMPORTFLAG=''' + ifThen(LabeledEdit2.Text='��','1','0') + 
                 ''',TAXFLAG=''' + ifThen(LabeledEdit3.Text='��','1','0') + ''',MEMO=''' + LabeledEdit5.Text +
                 ''',PORDERDTLID=''' + LabeledEdit6.Text + ''',GOODSID=''' + LabeledEdit7.Text +
                 ''',LOTNO=''' + LabeledEdit8.Text + ''',APPROVEDOCNO='''+
                 LabeledEdit9.Text +
                 ''',qty=' + LabeledEdit11.Text +
                 ',dtlmemo=''' + LabeledEdit12.Text +
                 ''',SRCID=''' + sSRCID +
    '''  Where    Unid='+inttostr(Insert_Identity);
//    adotemp11.Parameters.ParamByName('ARRIVEDATE').Value:=DateTimePicker2.Date ;
//    adotemp11.Parameters.ParamByName('VALIDDATE').Value:=DateTimePicker3.Date ;
//    adotemp11.Parameters.ParamByName('PRODDATE').Value:=DateTimePicker4.Date ;
    adotemp11.ExecSQL;
    ADOQuery1.Requery([]);
  end;

  adotemp11.Free;
  AdoQuery1.Locate('Unid',Insert_Identity,[loCaseInsensitive]) ;
end;

procedure TfrmInputASN.UpdateAdoQuery1;
var
  s1:string;
begin
  s1:=StringReplace(SelectAsn,'1z2y3xTABLENAME1T2S3Rc1','',[rfReplaceAll,rfIgnoreCase]);
  s1:=StringReplace(s1,'1z2y3xTABLENAME1T2S3Rc21w2v3uFIELDNAME1T2S3Rname','',[rfReplaceAll,rfIgnoreCase]);
  s1:=StringReplace(s1,'1z2y3xTABLENAME1T2S3Rc31w2v3uFIELDNAME1T2S3Rname','',[rfReplaceAll,rfIgnoreCase]);
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Text:=s1+' where convert(varchar(10),credate,111)=convert(varchar(10),getdate(),111)';
  ADOQuery1.Open;
end;

procedure TfrmInputASN.updateEdit;
var
  iIMPORTFLAG,iTAXFLAG:integer;
begin
  if not AdoQuery1.Active then exit;

  ComboBox1.Text:=AdoQuery1.fieldbyname('��������').asstring;
  LabeledEdit1.Text:=AdoQuery1.fieldbyname('�����ܵ�ID').asstring;
  if not trystrtoint(AdoQuery1.fieldbyname('����').AsString,iIMPORTFLAG) then iIMPORTFLAG:=0;
  LabeledEdit2.ItemIndex:=iIMPORTFLAG;
  if not trystrtoint(AdoQuery1.fieldbyname('��˰').AsString,iTAXFLAG) then iTAXFLAG:=0; 
  LabeledEdit3.ItemIndex:=iTAXFLAG;
  LabeledEdit4.Text:=AdoQuery1.fieldbyname('��Ӧ�̴���').asstring;
  LabeledEdit16.Text:=AdoQuery1.fieldbyname('��Ӧ������').asstring;
  LabeledEdit5.Text:=AdoQuery1.fieldbyname('�ܵ���ע').asstring;
  LabeledEdit6.Text:=AdoQuery1.fieldbyname('����ϸ��ID').asstring;
  LabeledEdit7.Text:=AdoQuery1.fieldbyname('��ƷID').asstring;
  LabeledEdit15.Text:=AdoQuery1.fieldbyname('Ʒ�����').asstring;
  LabeledEdit8.Text:=AdoQuery1.fieldbyname('����').asstring;
  LabeledEdit9.Text:=AdoQuery1.fieldbyname('��׼�ĺ�').asstring;
  //LabeledEdit10.Text:=AdoQuery1.fieldbyname('TRADEPACK').asstring;
  LabeledEdit11.Text:=AdoQuery1.fieldbyname('����').asstring;
  LabeledEdit12.Text:=AdoQuery1.fieldbyname('ϸ����ע').asstring;
  //LabeledEdit13.Text:=AdoQuery1.fieldbyname('packsize').asstring;
  //LabeledEdit14.Text:=AdoQuery1.fieldbyname('SRCID').asstring;

//  DateTimePicker2.Date:=AdoQuery1.fieldbyname('Ԥ��������').AsDateTime;
  if AdoQuery1.fieldbyname('ҵ������').AsString='7' then ComboBox2.Text:='�����˻�'
    else ComboBox2.Text:='�����ɹ�';
  //DateTimePicker3.Date:=AdoQuery1.fieldbyname('VALIDDATE').AsDateTime;
  //DateTimePicker4.Date:=AdoQuery1.fieldbyname('PRODDATE').AsDateTime;
end;

procedure TfrmInputASN.ADOQuery1AfterScroll(DataSet: TDataSet);
begin
  ifnewadd:=false;
  
  updateEdit;
end;

procedure TfrmInputASN.SpeedButton3Click(Sender: TObject);
var
  adotemp11,adotemp22:tadoquery;
  sIFSHIFANG:string;
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  adotemp22:=tadoquery.Create(nil);
  adotemp22.Connection:=DM.ADOConnection1;
  adotemp22.Close;
  adotemp22.SQL.Clear;
  adotemp22.SQL.Text:='select * from INF_INPT_asn_DTL_Z where unid='+ADOQuery1.fieldbyname('unid').AsString;
  adotemp22.Open;
  sIFSHIFANG:=adotemp22.fieldbyname('IFSHIFANG').AsString;
  adotemp22.Free;

  if sIFSHIFANG<>'' then
  begin
    MessageDlg('���ͷ�,����ɾ��!', mtError, [mbYes], 0);
    exit;
  end;

  if (MessageDlg('�Ƿ���Ҫɾ����ǰ��¼��', mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then exit;

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='delete from INF_INPT_ASN_DTL_Z where unid=' + ADOQuery1.fieldbyname('unid').AsString;
  adotemp11.ExecSQL;
  adotemp11.Free;

  ADOQuery1.Requery([]);
end;

procedure TfrmInputASN.LabeledEdit7KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.GetCodePos:=gcNone;
  tmpADOLYGetcode.IfNullGetCode:=false;
  tmpADOLYGetcode.OpenStr:='select id as ��Ʒ����,name as Ʒ����� from CommCode where TypeName=''��Ʒ����'' ';
  tmpADOLYGetcode.InField:='id,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=top+22{��ǰ����������߶�}+21{��ǰ����˵��߶�}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
    LabeledEdit15.Text:=tmpADOLYGetcode.OutValue[1];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TfrmInputASN.LabeledEdit4KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.GetCodePos:=gcNone;
  tmpADOLYGetcode.IfNullGetCode:=false;
  tmpADOLYGetcode.OpenStr:='select id as ��Ӧ�̴���,name as ��Ӧ������ from CommCode where TypeName=''�ͻ�����'' ';
  tmpADOLYGetcode.InField:='id,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=top+22{��ǰ����������߶�}+21{��ǰ����˵��߶�}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
    LabeledEdit16.Text:=tmpADOLYGetcode.OutValue[1];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TfrmInputASN.SpeedButton2Click(Sender: TObject);
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

procedure TfrmInputASN.N1Click(Sender: TObject);
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
  adotemp22.SQL.Text:='select * from INF_INPT_asn_DTL_Z where unid='+inttostr(iUnid);
  adotemp22.Open;
  sIFSHIFANG:=adotemp22.fieldbyname('IFSHIFANG').AsString;
  adotemp22.Free;

  if sIFSHIFANG<>'' then exit;
  
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='update INF_INPT_asn_DTL_Z set IFSHIFANG='''+operator_name+''',shifangtime=getdate() where unid='+inttostr(iUnid);
  adotemp11.ExecSQL;
  adotemp11.Free;

  ADOQuery1.Requery([]);

  AdoQuery1.Locate('Unid',iUnid,[loCaseInsensitive]) ;
end;

procedure TfrmInputASN.ADOQuery1AfterOpen(DataSet: TDataSet);
begin
  if not DataSet.Active then exit;
  
  dbgrid1.Columns[0].Width:=80;
  dbgrid1.Columns[1].Width:=70;
  dbgrid1.Columns[2].Width:=70;
  dbgrid1.Columns[3].Width:=60;//ҵ������
  dbgrid1.Columns[4].Width:=30;
  dbgrid1.Columns[5].Width:=30;
  dbgrid1.Columns[6].Width:=90;
  dbgrid1.Columns[7].Width:=70;
  dbgrid1.Columns[8].Width:=60;//��ƷID
  dbgrid1.Columns[9].Width:=100;//Ʒ�����
  dbgrid1.Columns[10].Width:=70;
  dbgrid1.Columns[11].Width:=70;
  dbgrid1.Columns[12].Width:=50;//����
  dbgrid1.Columns[13].Width:=70;
  dbgrid1.Columns[14].Width:=70;
  dbgrid1.Columns[15].Width:=100;
end;

initialization
  ffrmInputASN:=nil;

end.
