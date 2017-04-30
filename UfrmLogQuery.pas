unit UfrmLogQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, UADOLYQuery, DB, ADODB, Grids,
  DBGrids;

type
  TfrmLogQuery = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    lyquery1: TADOLYQuery;
    ADObasic: TADOQuery;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure ADObasicAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function frmLogQuery:TfrmLogQuery;    {��̬�������庯��}

implementation

uses UDM;

var
  ffrmLogQuery:TfrmLogQuery;           {���صĴ������,���رմ����ͷ��ڴ�ʱ����}

{$R *.dfm}

////////////////////////////////////////////////////////////////////////////////
function frmLogQuery:TfrmLogQuery;    {��̬�������庯��}
begin
  if ffrmLogQuery=nil then ffrmLogQuery:=TfrmLogQuery.Create(application.mainform);
  result:=ffrmLogQuery;
end;

procedure TfrmLogQuery.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmLogQuery=self then ffrmLogQuery:=nil;
end;
////////////////////////////////////////////////////////////////////////////////

procedure TfrmLogQuery.BitBtn1Click(Sender: TObject);
var
  sqlstr1:string;
  Save_Cursor:TCursor;
begin
  sqlstr1:='select '+
    ' UserName as ������,ActionTime as ����ʱ��,ActionName as ��������,'+
    ' Reserve4 as ��������,IP,ComputerName as ��������,Create_Date_Time,Unid '+
    ' from AppVisit ';
  
  lyquery1.Connection:=DM.ADOConnection1;
  lyquery1.SelectString:=sqlstr1;
  if lyquery1.Execute then
  begin
    ADObasic.SQL.Text:=lyquery1.ResultSelect;
    Save_Cursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;    { Show hourglass cursor }
    try
      ADObasic.Open;
    finally
      Screen.Cursor := Save_Cursor;  { Always restore to normal }
    end;
  end;
end;

procedure TfrmLogQuery.ADObasicAfterOpen(DataSet: TDataSet);
begin
  if not DataSet.Active then exit;

  dbgrid1.Columns[0].Width:=42;//������
  dbgrid1.Columns[1].Width:=130;//����ʱ��
  dbgrid1.Columns[2].Width:=130;//��������
  dbgrid1.Columns[3].Width:=500;//��������
  dbgrid1.Columns[4].Width:=110;//IP
  dbgrid1.Columns[5].Width:=150;//��������
  dbgrid1.Columns[6].Width:=130;//Create_Date_Time
  dbgrid1.Columns[7].Width:=50;//Unid
end;

initialization
  ffrmLogQuery:=nil;

end.
