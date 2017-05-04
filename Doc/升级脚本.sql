use ErpBill
go

--�ݵ��ԣ�����һ�λ������Σ����һ�����ű�

---------------����ز���---------------

--������AppVisit��ʹ��LIS�иñ�Ľű�

--INF_INPT_PKT_DTL_C
IF not EXISTS (select 1 from syscolumns where name='Amount' and id=object_id('INF_INPT_PKT_DTL_C'))
  Alter table INF_INPT_PKT_DTL_C add Amount Money null
GO


---------------������ز���---------------

---------------�洢������ز���---------------

---------------��ͼ��ز���---------------

--��ͼV_INF_INPT_PKT_DTL�Ĵ����ű�
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

---------------��������ز���---------------

---------------������ز���---------------

---------------��Լ����������ز���---------------

---------------���ϵ��ز���---------------

---------------���±�����ͼ---------------