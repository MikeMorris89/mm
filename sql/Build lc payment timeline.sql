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
select top 100
	a.id
	,a.member_id
	,issue_d = cast(issue_d as date)
	,rf_loan_end =cast(dateadd(mm,cast(ltrim(rtrim(replace(term,'months',''))) as int),issue_d) as date)
	,blend_loan_end =cast(
		coalesce(
		 case when loan_status = 'Fully Paid' or loan_status = 'Does not meet the credit policy. Status:Fully Paid' then last_pymnt_d else null end
		,dateadd(mm,cast(ltrim(rtrim(replace(term,'months',''))) as int),issue_d)
	 ) as date)
	,rf_term = cast(ltrim(rtrim(replace(term,'months',''))) as int)
	,blend_term =
		coalesce(
		 case when loan_status = 'Fully Paid' or loan_status = 'Does not meet the credit policy. Status:Fully Paid' then datediff(mm,issue_d,last_pymnt_d) else null end
		,cast(ltrim(rtrim(replace(term,'months',''))) as int)
	 )
	,last_pymnt_d = cast(last_pymnt_d as date)
	,last_pymnt_amnt = cast(last_pymnt_amnt as money)
	,total_pymnt  = cast(total_pymnt as money)
	,loan_status
	,int_rate
	,installment = cast(installment as money)
	,funded_amnt = cast(funded_amnt as money)
	
into tbl_pmts_001
from loan3 as a

select *
from tbl_pmts_001

select top 10 *
from loan3 
where loan_amnt <> funded_amnt

select loan_status, count(*)
from loan3 
group by loan_status


