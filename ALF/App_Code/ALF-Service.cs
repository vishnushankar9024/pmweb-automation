using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;


    /// <summary>
    /// Summary description for ALF_Service
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class ALF_Service : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }
    [WebMethod]
    public DataTable CostManagement_GetForecastList(int UserId)
    {
        SqlConnection conn = new SqlConnection();
        conn = AllClasses.AllClass.myConnection.GetConnection();

        SqlCommand cmdProc = new SqlCommand("ALF_CostManagement_GetForecastList", conn);
        cmdProc.Parameters.AddWithValue("@UserId", UserId);
        SqlDataAdapter adt = new SqlDataAdapter(cmdProc);
        cmdProc.CommandType = CommandType.StoredProcedure;
        DataTable dtb = new DataTable();
        if (conn.State == System.Data.ConnectionState.Closed)
        {
            conn.Open();
        }
        dtb.Columns.Add("ForecastId", typeof(int));
        dtb.Columns.Add("ProDesc", typeof(string));
        dtb.Columns.Add("Description", typeof(string));
        dtb.Columns.Add("RecordNumber", typeof(string));
        dtb.TableName = "ForecastDesc";
        adt.Fill(dtb);
        cmdProc.Dispose();
        adt.Dispose();
        conn.Close();
        return dtb;
    }
    [WebMethod]
    public DataTable CostManagement_GetForecastById(int Id,int UserId)
    {
        SqlConnection conn = new SqlConnection();
        conn = AllClasses.AllClass.myConnection.GetConnection();

        SqlCommand cmdProc = new SqlCommand("CostManagement_GetForecastById", conn);
        cmdProc.Parameters.AddWithValue("@Id", Id);
        cmdProc.Parameters.AddWithValue("@UserId", UserId);
        SqlDataAdapter adt = new SqlDataAdapter(cmdProc);
        cmdProc.CommandType = CommandType.StoredProcedure;
        DataTable dtb = new DataTable();
        if (conn.State == System.Data.ConnectionState.Closed)
        {
            conn.Open();
        }
        dtb.Columns.Add("ForecastId", typeof(int));
        dtb.Columns.Add("Description", typeof(string));
        dtb.Columns.Add("ProjectId", typeof(int));
        dtb.Columns.Add("ProjectName", typeof(string));
        dtb.Columns.Add("ProjectFullName", typeof(string));
        dtb.Columns.Add("RecordNumber", typeof(string));
        dtb.Columns.Add("PeriodId", typeof(int));
        dtb.Columns.Add("RevisionNumber", typeof(int));
        dtb.Columns.Add("RevisionDate", typeof(DateTime));
        dtb.Columns.Add("DocStatusId", typeof(int));
        dtb.Columns.Add("IncludePendingBudget", typeof(int));
        dtb.Columns.Add("IncludePendingCost", typeof(int));
        dtb.Columns.Add("IncludePendingActualCost", typeof(int));
        dtb.Columns.Add("IsPosted", typeof(int));
        dtb.Columns.Add("HasReports", typeof(int));
        dtb.Columns.Add("HasMergeTemplate", typeof(int));
        dtb.Columns.Add("RecordDescription", typeof(string));
        dtb.Columns.Add("IsUseUnit", typeof(int));
        dtb.Columns.Add("CashFlowYear", typeof(int));
        dtb.Columns.Add("IncludeAllMonths", typeof(int));
        dtb.Columns.Add("HasSnapshot", typeof(int));
        dtb.Columns.Add("CreateDate", typeof(DateTime));
        dtb.Columns.Add("CreatedByUserName", typeof(string));
        dtb.Columns.Add("CreatedByUserCompany", typeof(string));
        dtb.Columns.Add("CreatedById", typeof(int));
        dtb.Columns.Add("Reference", typeof(string));
        dtb.Columns.Add("CategoryId", typeof(int));
        dtb.Columns.Add("Period", typeof(string));
        dtb.Columns.Add("CurrencyId", typeof(int));
        dtb.TableName = "ForecastDesc";
        adt.Fill(dtb);
        cmdProc.Dispose();
        adt.Dispose();
        conn.Close();
        return dtb;
    }

    [WebMethod]
    public DataTable CostManagement_GetForecastDetails(int ForecastId, int UserId)
    {
        SqlConnection conn = new SqlConnection();
        conn = AllClasses.AllClass.myConnection.GetConnection();

        SqlCommand cmdProc = new SqlCommand("CostManagement_GetForecastDetails", conn);
        cmdProc.Parameters.AddWithValue("@ForecastId", ForecastId);
        cmdProc.Parameters.AddWithValue("@UserId", UserId);
        SqlDataAdapter adt = new SqlDataAdapter(cmdProc);
        cmdProc.CommandType = CommandType.StoredProcedure;
        DataTable dtb = new DataTable();
        if (conn.State == System.Data.ConnectionState.Closed)
        {
            conn.Open();
        }
        dtb.Columns.Add("Id", typeof(int));
        dtb.Columns.Add("CostcodeId", typeof(int));
        dtb.Columns.Add("Costcode", typeof(string));
        dtb.Columns.Add("Description", typeof(string));
        dtb.Columns.Add("AnticipatedBudgetApproved", typeof(float));
        dtb.Columns.Add("AnticipatedBudgetApprovedConverted", typeof(float));
        dtb.Columns.Add("AnticipatedBudgetPending", typeof(float));
        dtb.Columns.Add("AnticipatedBudgetPendingConverted", typeof(float));
        dtb.Columns.Add("AnticipatedCostApproved", typeof(float));
        dtb.Columns.Add("AnticipatedCostApprovedConverted", typeof(float));
        dtb.Columns.Add("AnticipatedCostPending", typeof(float));
        dtb.Columns.Add("AnticipatedCostPendingConverted", typeof(float));
        dtb.Columns.Add("ActualCostApproved", typeof(float));
        dtb.Columns.Add("ActualCostApprovedConverted", typeof(float));
        dtb.Columns.Add("ActualCostPending", typeof(float));
        dtb.Columns.Add("ActualCostPendingConverted", typeof(float));
        dtb.Columns.Add("ForecastToComplete", typeof(float));
        dtb.Columns.Add("ForecastToCompleteConverted", typeof(float));
        dtb.Columns.Add("UOMId", typeof(int));
        dtb.Columns.Add("UOM", typeof(string));
        dtb.Columns.Add("Quantity", typeof(int));
        dtb.Columns.Add("UnitCost", typeof(float));
        dtb.Columns.Add("UnitCostConverted", typeof(float));
        dtb.Columns.Add("TaskId", typeof(int));
        dtb.Columns.Add("Task", typeof(string));
        dtb.Columns.Add("StartDate", typeof(DateTime));
        dtb.Columns.Add("StartDateReminder", typeof(DateTime));
        dtb.Columns.Add("FinishDate", typeof(DateTime));
        dtb.Columns.Add("FinishDateReminder", typeof(DateTime));
        dtb.Columns.Add("CurveId", typeof(int));
        dtb.Columns.Add("Curve", typeof(string));
        dtb.Columns.Add("PctComplete", typeof(float));
        dtb.Columns.Add("PctComplete", typeof(float));
        dtb.Columns.Add("Notes", typeof(string));
        dtb.Columns.Add("UseEditedForecastToComplete", typeof(int));
        dtb.Columns.Add("PeriodId", typeof(int));
        dtb.Columns.Add("Period", typeof(string));
        dtb.Columns.Add("QuantityBudgeted", typeof(float));
        dtb.Columns.Add("QuantityCompleted", typeof(int));
        dtb.Columns.Add("TotalBudget", typeof(float));
        dtb.Columns.Add("TotalBudgetConverted", typeof(float));
        dtb.Columns.Add("Group1", typeof(string));
        dtb.Columns.Add("CurrencyId", typeof(int));
        dtb.Columns.Add("Currency", typeof(string));
        dtb.Columns.Add("ConversionRate", typeof(float));
        dtb.Columns.Add("Field1", typeof(string));
        dtb.Columns.Add("Field2", typeof(string));
        dtb.Columns.Add("Field3", typeof(string));
        dtb.Columns.Add("Field4", typeof(string));
        dtb.Columns.Add("Field5", typeof(string));
        dtb.Columns.Add("Field6", typeof(string));
        dtb.Columns.Add("Field7", typeof(string));
        dtb.Columns.Add("Field8", typeof(string));
        dtb.Columns.Add("Field9", typeof(string));
        dtb.Columns.Add("Field10", typeof(string));
        dtb.Columns.Add("HasProjection", typeof(int));
        dtb.Columns.Add("AttachmentTotal", typeof(float));
        dtb.Columns.Add("HasSnapShot", typeof(int));
        dtb.TableName = "ForecastDesc";
        adt.Fill(dtb);
        cmdProc.Dispose();
        adt.Dispose();
        conn.Close();
        return dtb;
    }
    [WebMethod]
    public DataTable CostManagement_AddForecast(string Description, int ProjectId, string RecordNumber,int PeriodId, int DocStatusId,int IncludePendingBudget
        ,int IncludePendingCost,int IncludePendingActualCost,int UserId,int RevisionNumber,int CategoryId, string Reference,int CurrencyId)
    {
        SqlConnection conn = new SqlConnection();
        conn = AllClasses.AllClass.myConnection.GetConnection();

        SqlCommand cmdProc = new SqlCommand("CostManagement_AddForecast", conn);
        cmdProc.Parameters.AddWithValue("@Description", Description);
        cmdProc.Parameters.AddWithValue("@ProjectId", ProjectId);
        cmdProc.Parameters.AddWithValue("@RecordNumber", RecordNumber);
        cmdProc.Parameters.AddWithValue("@PeriodId", PeriodId);
        cmdProc.Parameters.AddWithValue("@DocStatusId", DocStatusId);
        cmdProc.Parameters.AddWithValue("@IncludePendingBudget", IncludePendingBudget);
        cmdProc.Parameters.AddWithValue("@IncludePendingCost", @IncludePendingCost);
        cmdProc.Parameters.AddWithValue("@IncludePendingActualCost", @IncludePendingActualCost);
        cmdProc.Parameters.AddWithValue("@UserId", UserId);
        cmdProc.Parameters.AddWithValue("@RevisionNumber", RevisionNumber);
        cmdProc.Parameters.AddWithValue("@CategoryId", CategoryId);
        cmdProc.Parameters.AddWithValue("@Reference", Reference);
        cmdProc.Parameters.AddWithValue("@CurrencyId", CurrencyId);
        SqlDataAdapter adt = new SqlDataAdapter(cmdProc);
        cmdProc.CommandType = CommandType.StoredProcedure;
        DataTable dtb = new DataTable();
        if (conn.State == System.Data.ConnectionState.Closed)
        {
            conn.Open();
        }
        dtb.Columns.Add("ForecastId", typeof(int));
        dtb.TableName = "CostManagement_AddForecast";
        adt.Fill(dtb);
        cmdProc.Dispose();
        adt.Dispose();
        conn.Close();
        return dtb;
    }
    [WebMethod]
    public DataTable CostManagement_AddForecastDetails(int ForecastId, string CostCodeIds, int UserId, int IncludeNotes)
    {
        SqlConnection conn = new SqlConnection();
        conn = AllClasses.AllClass.myConnection.GetConnection();

        SqlCommand cmdProc = new SqlCommand("CostManagement_AddForecastDetails", conn);
        cmdProc.Parameters.AddWithValue("@ForecastId", ForecastId);
        cmdProc.Parameters.AddWithValue("@CostCodeIds", CostCodeIds);
        cmdProc.Parameters.AddWithValue("@UserId", UserId);
        cmdProc.Parameters.AddWithValue("@IncludeNotes", IncludeNotes);
        SqlDataAdapter adt = new SqlDataAdapter(cmdProc);
        cmdProc.CommandType = CommandType.StoredProcedure;
        DataTable dtb = new DataTable();
        if (conn.State == System.Data.ConnectionState.Closed)
        {
            conn.Open();
        }
        dtb.TableName = "CostManagement_AddForecastDetails";
        adt.Fill(dtb);
        cmdProc.Dispose();
        adt.Dispose();
        conn.Close();
        return dtb;
    }

    [WebMethod]
    public DataTable CostManagement_AddForecastCost(int ForecastDetailId, string Description, int UOMId, float Quantity,float UnitCost,float TotalAmount, string Notes,
        int PeriodId )
    {
        SqlConnection conn = new SqlConnection();
        conn = AllClasses.AllClass.myConnection.GetConnection();

        SqlCommand cmdProc = new SqlCommand("CostManagement_AddForecastCost", conn);
        cmdProc.Parameters.AddWithValue("@ForecastDetailId", ForecastDetailId);
        cmdProc.Parameters.AddWithValue("@Description", Description);
        cmdProc.Parameters.AddWithValue("@UOMId", UOMId);
        cmdProc.Parameters.AddWithValue("@Quantity", Quantity);
        cmdProc.Parameters.AddWithValue("@UnitCost", UnitCost);
        cmdProc.Parameters.AddWithValue("@TotalAmount", TotalAmount);
        cmdProc.Parameters.AddWithValue("@Notes", Notes);
        cmdProc.Parameters.AddWithValue("@PeriodId", PeriodId);

        SqlDataAdapter adt = new SqlDataAdapter(cmdProc);
        cmdProc.CommandType = CommandType.StoredProcedure;
        DataTable dtb = new DataTable();
        if (conn.State == System.Data.ConnectionState.Closed)
        {
            conn.Open();
        }
        dtb.TableName = "CostManagement_AddForecastDetails";
        adt.Fill(dtb);
        cmdProc.Dispose();
        adt.Dispose();
        conn.Close();
        return dtb;
    }

    [WebMethod]
    public DataTable CostManagement_DeleteForecast(int Id, int UserId)
    {
        SqlConnection conn = new SqlConnection();
        conn = AllClasses.AllClass.myConnection.GetConnection();

        SqlCommand cmdProc = new SqlCommand("CostManagement_DeleteForecast", conn);
        cmdProc.Parameters.AddWithValue("@Id", Id);
        cmdProc.Parameters.AddWithValue("@UserId", UserId);

        SqlDataAdapter adt = new SqlDataAdapter(cmdProc);
        cmdProc.CommandType = CommandType.StoredProcedure;
        DataTable dtb = new DataTable();
        if (conn.State == System.Data.ConnectionState.Closed)
        {
            conn.Open();
        }
        dtb.TableName = "CostManagement_DeleteForecast";
        adt.Fill(dtb);
        cmdProc.Dispose();
        adt.Dispose();
        conn.Close();
        return dtb;
    }

    [WebMethod]
    public DataTable CostManagement_DeleteForecastDetail(int Id, int UserId)
    {
        SqlConnection conn = new SqlConnection();
        conn = AllClasses.AllClass.myConnection.GetConnection();

        SqlCommand cmdProc = new SqlCommand("CostManagement_DeleteForecastDetail", conn);
        cmdProc.Parameters.AddWithValue("@Id", Id);
        cmdProc.Parameters.AddWithValue("@UserId", UserId);

        SqlDataAdapter adt = new SqlDataAdapter(cmdProc);
        cmdProc.CommandType = CommandType.StoredProcedure;
        DataTable dtb = new DataTable();
        if (conn.State == System.Data.ConnectionState.Closed)
        {
            conn.Open();
        }
        dtb.TableName = "CostManagement_DeleteForecastDetail";
        adt.Fill(dtb);
        cmdProc.Dispose();
        adt.Dispose();
        conn.Close();
        return dtb;
    }
    [WebMethod]
    public DataTable CostManagement_DeleteForecastCosts(int DetailId)
    {
        SqlConnection conn = new SqlConnection();
        conn = AllClasses.AllClass.myConnection.GetConnection();

        SqlCommand cmdProc = new SqlCommand("DetailId", conn);

        cmdProc.Parameters.AddWithValue("@DetailId", DetailId);

        SqlDataAdapter adt = new SqlDataAdapter(cmdProc);
        cmdProc.CommandType = CommandType.StoredProcedure;
        DataTable dtb = new DataTable();
        if (conn.State == System.Data.ConnectionState.Closed)
        {
            conn.Open();
        }
        dtb.TableName = "CostManagement_DeleteForecastCosts";
        adt.Fill(dtb);
        cmdProc.Dispose();
        adt.Dispose();
        conn.Close();
        return dtb;
    }
}
