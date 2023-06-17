using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Data;
using System.Data.OleDb;
using System.IO;
using System.Data.SqlClient;
using VFPOLEDBLib;

namespace medesignsoft
{
    public class dbConnExpress
    {
        string _ConnectionString;
        //SqlConnection cn;
        OleDbConnection cnx;

        
        public string ConnectionString
        {
            get { return _ConnectionString; }
            set { _ConnectionString = value; }
        }

        public dbConnExpress()
        {
            string strPath = HttpContext.Current.Server.MapPath("~/ClassConn/dbConnExpress.txt");
            var ReadString = File.ReadAllText(strPath);
            ConnectionString = ReadString;
        }

        public OleDbConnection OpenConn()
        {
            cnx= new OleDbConnection(ConnectionString);
            cnx.Open();
            return cnx;
        }

        public void CloseConn()
        {
            if (cnx != null) cnx.Close();
        }

        public DataSet GetDataSet(string sql)
        {
            DataSet ds = new DataSet();
            try
            {
                cnx = OpenConn();
               OleDbDataAdapter  da = new OleDbDataAdapter(sql, cnx);
                da.Fill(ds);
                return ds;
            }
            catch (Exception)
            {
                return null;
            }
            finally
            {
                CloseConn();
            }
        }

        public DataSet GetDataSet(string sql, string dsname)
        {
            DataSet ds = new DataSet();
            try
            {
                cnx = OpenConn();
                OleDbDataAdapter  da = new OleDbDataAdapter(sql, cnx);
                da.Fill(ds, "dataset");
                return ds;
            }
            catch (Exception)
            {
                return null;
            }
            finally
            {
                CloseConn();
            }
        }

        public DataSet GetDataSet(string sql, string dsname, OleDbTransaction trans)
        {
            DataSet ds = new DataSet();
            try
            {
                OleDbDataAdapter da = new OleDbDataAdapter(sql, trans.Connection);
                da.SelectCommand.Transaction = trans;
                da.Fill(ds, "dataset");
                return ds;
            }
            catch (Exception)
            {
                return null;
            }
            finally
            {
                CloseConn();
            }
        }

        public DataTable GetDataTable(string sql)
        {
            DataTable dt = new DataTable();
            try
            {
                cnx = OpenConn();
                OleDbDataAdapter da = new OleDbDataAdapter(sql, cnx);
                da.Fill(dt);
                return dt;
            }
            catch (Exception)
            {
                return null;
            }
            finally
            {
                CloseConn();
            }
        }

        public DataTable GetDataTable(string sql, string dtname)
        {
            DataTable dt = new DataTable();
            try
            {
                cnx = OpenConn();
                OleDbDataAdapter da = new OleDbDataAdapter(sql, cnx);
                da.Fill(dt);
                return dt;
            }
            catch (Exception)
            {
                return null;
            }
            finally
            {
                CloseConn();
            }
        }

        public DataTable GetDataTable(string sql, string dtname, OleDbTransaction trans)
        {
            DataTable dt = new DataTable();
            try
            {
                OleDbDataAdapter da = new OleDbDataAdapter(sql, trans.Connection);
                da.SelectCommand.Transaction = trans;
                da.Fill(dt);
                return dt;
            }
            catch (Exception)
            {
                return null;
            }
            finally
            {
                CloseConn();
            }
        }

        public OleDbDataReader GetDataReader(string sql)
        {
            try
            {
                cnx = OpenConn();
                OleDbCommand comm = new OleDbCommand(sql, cnx);
                OleDbDataReader dr = comm.ExecuteReader();
                return dr;
            }
            catch (Exception)
            {
                return null;
            }
            finally
            {
                CloseConn();
            }
        }

        public DataSet ExecuteDataSet(OleDbCommand cmd)
        {
            DataSet ds = new DataSet();
            try
            {
                OleDbDataAdapter da = new OleDbDataAdapter(cmd);
                da.SelectCommand = cmd;
                da.Fill(ds);
                return ds;
            }
            catch (Exception)
            {
                return null;
            }
            finally
            {
                CloseConn();
            }
        }

        public DataTable ExcuteDataTable(OleDbCommand cmd)
        {
            DataTable dt = new DataTable();
            try
            {
                OleDbDataAdapter da = new OleDbDataAdapter(cmd);
                da.SelectCommand = cmd;
                da.Fill(dt);
                return dt;
            }
            catch (Exception)
            {
                return null;
            }
            finally
            {
                CloseConn();
            }
        }
    }
}