use ErpBill
go

--幂等性（调用一次或无数次，后果一样）脚本

---------------表相关操作---------------

--新增表AppVisit，与LIS中该表一致
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AppVisit]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
create table AppVisit
 (Unid int identity primary key,
  SysName varchar (20) NULL,
  PageName varchar (10) NULL,
  IP varchar (20) NULL,
  Customer varchar (50) NULL,
  UserName varchar (20) NULL,
  ActionName varchar (50) NULL,
  ActionTime datetime NULL,
  Remark varchar (100) NULL,
  Reserve varchar(100) NULL,
  Reserve2 varchar (200) NULL,
  Reserve3 varchar (200) NULL,
  Reserve4 varchar (200) NULL,
  Reserve5 int NULL,
  Reserve6 int NULL,
  Reserve7 float NULL,
  Reserve8 float NULL,
  Reserve9 datetime NULL,
  Reserve10 datetime NULL,
  Create_Date_Time datetime NULL DEFAULT (getdate())
)
GO

IF NOT EXISTS (select 1 from syscolumns where name='ComputerName' and id=object_id('AppVisit'))
begin
  Alter table AppVisit add ComputerName varchar (50) null--计算机名称
end
go

--INF_INPT_PKT_DTL_C
IF not EXISTS (select 1 from syscolumns where name='Amount' and id=object_id('INF_INPT_PKT_DTL_C'))
  Alter table INF_INPT_PKT_DTL_C add Amount Money null
GO


---------------函数相关操作---------------

---------------存储过程相关操作---------------

---------------视图相关操作---------------

--视图V_INF_INPT_PKT_DTL的创建脚本
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[V_INF_INPT_PKT_DTL]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[V_INF_INPT_PKT_DTL]
GO

CREATE view [dbo].[V_INF_INPT_PKT_DTL] AS 
SELECT
	[GOODSOWNERID],
	[EXPORDERID] ,
	Z.UNID,
	CONVERT(VARCHAR(19),CREDATE,121) AS CREDATE,
	CONVERT(VARCHAR(19),PREEXPDATE,121) AS PREEXPDATE ,
	[EXPCOMPANYID],
	[COMPANYSTYLE],
	[JOBTYPE],
	[ADDINVOICEFLAG] ,
	[COMPANYTYPE],
	[OPERATIONTYPE],
	[MEDICINECLASS] ,
	[RECEIVEADDR] ,
	[RECEIVEHEAD]  ,
	[RECEIVEMAN],
	[SAMELOTFLAG]  ,
	[TAXFLAG]  ,
	[TRANSMODEID] ,
	[URGENFLAG] ,
	[DTLLINES],
	[MEMO]  ,

	[EXPORDERDTLID] ,
	[GOODSID] ,
	[GSTARAGEID],
	[BATCHNO] ,
	[LOTNO]  ,
	CONVERT(VARCHAR(19),VALIDDATE,121) AS VALIDDATE ,
	CONVERT(VARCHAR(19),PRODDATE,121) AS PRODDATE ,
	[GOODSTATUS] ,
	[QUANSTATUS],
	[APPROVEDOCNO] ,
	[TRADEPACK],
	[QTY] ,
	[ADDMEDCHECKFLAG] ,
	[DTLMEMO] ,
	[PARTEXPFLAG] ,
	[OUTMODE],
	[INVOICETYPE] ,
	[PLACESUPPLYID]  ,
	[PLACESUPPLYDTLID]  ,
	[PLACEPRICE] ,
	[RESALEPRICE]  ,
	[PLACEMONEY] ,
	[OTCFLAG] ,
	[TRADEMARK] ,
	[QUALITYDOCNO]  ,
	[GOODSCLASSNAME],
	[PACKSIZE] ,
	[ISBOXUP],
	[PLANARRIVE] ,
	[PIONARRIVE],
	[ADDRESSEID] ,
	[SPELLBILLNO] ,
	[SPECIALTYPE]  ,
	[DEPTNO]  ,
	[DEPTNAME]  ,
	[AMT]  ,
	[WHID],
	[ORDERFLAG]  ,
	[SRCID],
	[GOODSSUPPLYID],
        [Amount] 

	FROM INF_INPT_PKT_DTL_Z Z,INF_INPT_PKT_DTL_C C
WHERE Z.UNID=C.PKUNID
and GOODSOWNERID='21'
and z.IFSHIFANG is not null
and z.UpLoadTime is null

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

---------------触发器相关操作---------------

---------------数据相关操作---------------

---------------表约束、索引相关操作---------------

---------------表关系相关操作---------------

---------------重新编译视图---------------