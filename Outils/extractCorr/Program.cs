using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using FirebirdSql.Data.FirebirdClient;
using WinSCP;

namespace extractCorr
{

    internal class Program
    {
        static void exportToCsv(FbConnection c, string sql, string outputPath)
        {
            var csv = new StringBuilder();
            using (var transaction = c.BeginTransaction())
            {
                try
                {
                    using (var command = new FbCommand(sql, c, transaction))
                    {

                        using (var reader = command.ExecuteReader())
                        {
                            var columnCount = reader.FieldCount;
                            var header = new string[columnCount];
                            for (int i = 0; i < columnCount; i++)
                            {
                                header[i] = reader.GetName(i);
                            }
                            csv.AppendLine(string.Join(";", header));

                            while (reader.Read())
                            {
                                var values = new object[columnCount];
                                reader.GetValues(values);
                                csv.AppendLine(string.Join(";", values));
                            }

                            File.WriteAllText(outputPath, csv.ToString());
                        }
                    }
                }
                catch (FbException ex)
                {
                    Console.WriteLine("Erreur: {0}", ex);
                    Console.WriteLine("Ttable: {0}", outputPath);


                }
            }
        }
        static void archiveCsv(string projectName, string projectPath, string cip)
        {
            var files = new string[] { projectPath+cip+"_produits.csv", projectPath+cip+"_clients.csv", projectPath+cip+"_fournisseurs.csv", projectPath+cip+"_operateurs.csv" };
            using (var archive = ZipFile.Open(projectPath + projectName + ".zip", ZipArchiveMode.Create))
            {
                foreach (var fPath in files)
                {
                    archive.CreateEntryFromFile(fPath, Path.GetFileName(fPath));
                }
            }

        }

        static void uploadToFtp(string projectName, string projectPath)
        {
            using (var client = new System.Net.WebClient())
            {
                try
                {
                    client.Credentials = new System.Net.NetworkCredential("commit", "commit");
                    string file = projectPath + projectName + ".zip";
                    Console.WriteLine(file);
                    client.UploadFile("ftp://repf.groupe.pharmagest.com/uploads/migrationsLGO2/" + projectName + ".zip", file);
                }
                catch (Exception e)
                {

                    Console.WriteLine("Error: {0}", e);
                }

            }
        }

        static void uploadToSFTP(string projectName, string projectPath)
        {
            try
            {
                SessionOptions sessionOptions = new SessionOptions
                {
                    Protocol = Protocol.Sftp,
                    PortNumber = 2222,
                    HostName = "185.58.228.66",
                    UserName = "LGO_LGPI",
                    Password = "wPZ-b5L92<d$",
                    SshHostKeyFingerprint = "ssh-rsa 2048 k1ydHQr8pKXFt63IoWgxPeoRFjcwNtSdH3e8+MHpt8E",
                };

                using (Session session = new Session())
                {
                    string file = projectPath + projectName + ".zip";
                    session.Open(sessionOptions);
                    TransferOptions transferOptions = new TransferOptions();
                    transferOptions.TransferMode = TransferMode.Binary;
                    transferOptions.ResumeSupport.State = TransferResumeSupportState.Off;
                    TransferOperationResult transferResult;
                    transferResult =
                        session.PutFiles(file, "/IN/transco_migration/", false, transferOptions);

                    transferResult.Check();
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("Error: {0}", e);
            }
        }
        static void Main(string[] args)
        {
            String appPath = args[0];
            Console.WriteLine(appPath);
            String projectPath = args[1] + '\\';
            Console.WriteLine(projectPath);
            String cip = args[2];
            Console.WriteLine(cip);
            string projectName = "Transfert"+cip+"-"+DateTime.Now.Day+DateTime.Now.Month+DateTime.Now.Year;
            Console.WriteLine(projectName);

            var csb = new FbConnectionStringBuilder();
            csb.DataSource = "localhost";
            csb.ServerType = FbServerType.Embedded;
            csb.ClientLibrary = String.Format(@"{0}\fb\fbclient.dll", appPath);
            csb.Database = String.Format(@"{0}\PHA.FDB", projectPath);
            csb.UserID = "sysdba";
            csb.Password = "masterkey";
            var cs = csb.ToString();
 
            Console.WriteLine(cs);

            FbConnection c = new FbConnection(cs);
            
            c.InitializeLifetimeService();
            c.Open();
            
                   
            var queryTables = "SELECT RDB$RELATION_NAME FROM RDB$RELATIONS WHERE RDB$SYSTEM_FLAG = 0";
            var tableNames = new List<string>();

            using (var command = new FbCommand(queryTables, c))
            {
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        tableNames.Add(reader.GetString(0));
                    }
                }
            }

            foreach (var tableName in tableNames)
            {
                var query = $"SELECT * FROM {tableName}";
                var outputPath = projectPath + cip + "_" + tableName.ToLower() + ".csv";
                exportToCsv(c, query, outputPath);
            }

            archiveCsv(projectName, projectPath, cip);
         
        }
    }
}
