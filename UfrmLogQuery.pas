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

function frmLogQuery:TfrmLogQuery;    {动态创建窗体函数}

implementation

uses UDM;

var
  ffrmLogQuery:TfrmLogQuery;           {本地的窗体变量,供关闭窗体释放内存时调用}

{$R *.dfm}

////////////////////////////////////////////////////////////////////////////////
function frmLogQuery:TfrmLogQuery;    {动态创建窗体函数}
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
    ' UserName as 操作人,ActionTime as 操作时间,ActionName as 动作名称,'+
    ' Reserve4 as 动作详情,IP,ComputerName as 电脑名称,Create_Date_Time,Unid '+
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

  dbgrid1.Columns[0].Width:=42;//操作人
  dbgrid1.Columns[1].Width:=130;//操作时间
  dbgrid1.Columns[2].Width:=130;//动作名称
  dbgrid1.Columns[3].Width:=500;//动作详情
  dbgrid1.Columns[4].Width:=110;//IP
  dbgrid1.Columns[5].Width:=150;//电脑名称
  dbgrid1.Columns[6].Width:=130;//Create_Date_Time
  dbgrid1.Columns[7].Width:=50;//Unid
end;

initialization
  ffrmLogQuery:=nil;

end.
