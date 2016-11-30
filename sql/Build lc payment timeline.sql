USE [kaggle_public]
GO

select *
from dbo.loan3
/*
The execution was successful

- Initializing Data Flow Task (Success)

- Initializing Connections (Success)

- Setting SQL Command (Success)

- Setting Source Connection (Success)

- Setting Destination Connection (Success)

- Validating (Success)

- Prepare for Execute (Success)

- Pre-execute (Success)
	Messages
	* Information 0x402090dc: Data Flow Task 1: The processing of file "C:\Users\mikem\Dropbox\loan.csv" has started.
	 (SQL Server Import and Export Wizard)
	

- Executing (Success)

- Copying to [dbo].[loan3] (Success)
	* 887379 rows transferred

	Messages
	* Information 0x402090de: Data Flow Task 1: The total number of data rows processed for file "C:\Users\mikem\Dropbox\loan.csv" is 887380.
	 (SQL Server Import and Export Wizard)
	
	* Information 0x402090df: Data Flow Task 1: The final commit for the data insertion in "Destination - loan3" has started.
	 (SQL Server Import and Export Wizard)
	
	* Information 0x402090e0: Data Flow Task 1: The final commit for the data insertion  in "Destination - loan3" has ended.
	 (SQL Server Import and Export Wizard)
	

- Post-execute (Success)
	Messages
	* Information 0x402090dd: Data Flow Task 1: The processing of file "C:\Users\mikem\Dropbox\loan.csv" has ended.
	 (SQL Server Import and Export Wizard)
	
	* Information 0x4004300b: Data Flow Task 1: "Destination - loan3" wrote 887379 rows.
	 (SQL Server Import and Export Wizard)
*/
drop table tbl_pmts_001
select top 100
	 id = cast(id as int)
	,member_id = cast(member_id as int)
	,loan_status = cast(loan_status as char(51))
	,loan_dt = cast(issue_d as date)
	,co_dt = case when loan_status in ('Default','Charged Off') then dateadd(dd,150,cast(issue_d as date)) else null end
	,rf_loan_end_dt =cast(dateadd(mm,cast(ltrim(rtrim(replace(term,'months',''))) as int),issue_d) as date)
	,blend_loan_end_dt =cast(
		coalesce(
		 case when loan_status = 'Fully Paid' or loan_status = 'Does not meet the credit policy. Status:Fully Paid' then last_pymnt_d else null end
		,dateadd(mm,cast(ltrim(rtrim(replace(term,'months',''))) as int),issue_d)
	 ) as date)
	,rf_term_n = cast(ltrim(rtrim(replace(term,'months',''))) as int)
	,blend_term_n =
		coalesce(
		 case when loan_status = 'Fully Paid' or loan_status = 'Does not meet the credit policy. Status:Fully Paid' then datediff(mm,issue_d,last_pymnt_d) else null end
		,cast(ltrim(rtrim(replace(term,'months',''))) as int)
	 )
	,last_pymnt_dt = cast(last_pymnt_d as date)
	,last_pymnt_amnt_m = cast(last_pymnt_amnt as money)
	,total_pymnt_m  = cast(total_pymnt as money)
	,int_rate_d = cast(int_rate as decimal(19,10)) 
	,installment = cast(installment as money)
	,funded_amnt = cast(funded_amnt as money)	
into tbl_pmts_001
from loan3 as a

select *
from tbl_pmts_001

select top 10 *
from loan3 
where loan_amnt <> funded_amnt

select top 10 *
from loan3 
where isnumeric(id)=0

select top 10 *
from loan3 
where isnumeric(member_id)=0

select max(cast(id as numeric)),max(cast(member_id as numeric))
from loan3 

select max(len(loan_status))
from loan3 

select loan_status, count(*)
from loan3 
group by loan_status
/*
loan_status	(No column name)
Fully Paid	207723
Default	1219
Charged Off	45248
Current	601779
Late (31-120 days)	11591
Late (16-30 days)	2357
Does not meet the credit policy. Status:Charged Off	761
In Grace Period	6253
Issued	8460
Does not meet the credit policy. Status:Fully Paid	1988
*/



