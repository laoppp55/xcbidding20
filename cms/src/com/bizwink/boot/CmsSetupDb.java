package com.bizwink.boot;

import java.sql.*;
import java.util.*;
import java.io.*;

public class CmsSetupDb {

    private Connection m_con;
    private Vector m_errors;
    private String m_basePath;
    private boolean m_errorLogging = true;
    private final String C_OCSETUP_FOLDER = "WEB-INF/db_script/";

    public CmsSetupDb(String basePath) {
        m_errors = new Vector();
        m_basePath = basePath;
    }

    public void setConnection(String DbDriver, String DbConStr, String DbUser, String DbPwd) {
        try {
            Class.forName(DbDriver);
            m_con = DriverManager.getConnection(DbConStr,DbUser,DbPwd);
        }
        catch (SQLException e)  {
            m_errors.addElement("Could no connect to database via: " + DbConStr + "\n" + e.toString() + "\n");
        }
        catch (ClassNotFoundException e)  {
            m_errors.addElement("Error while loading driver: " + DbDriver + "\n" + e.toString() + "\n");
        }
    }

    public void closeConnection() {
        try {
            m_con.close();
        }
        catch (Exception e)  {}
    }

    public void dropDatabase(String resourceBroker, Hashtable replacer) {
        String file = getScript(resourceBroker+".dropdb");
        if (file != null) {
            m_errorLogging = true;
            parseScript(file,replacer);
        }
        else  {
            m_errors.addElement("Could not open database drop script: " + resourceBroker + ".dropdb");
        }
    }

    public void createDatabase(String resourceBroker, Hashtable replacer) {
        String file = getScript(resourceBroker+".createdb");
        if (file != null) {
            m_errorLogging = true;
            parseScript(file,replacer);
        }
        else  {
            m_errors.addElement("No create database script found: " + resourceBroker + ".createdb \n");
        }
    }

    public void createTables(String resourceBroker) {
        String file = getScript(resourceBroker+".createtables");
        if (file != null) {
            m_errorLogging = true;
            parseScript(file,null);
        }
        else  {
            m_errors.addElement("No create tables script found: " + resourceBroker + ".createtables \n");
        }
    }

    private void parseScript(String file, Hashtable replacers)   {

      /* indicates if the setup script contains included files (oracle) */
        boolean includedFile = false;

      /* get and parse the setup script */
        try {
            LineNumberReader reader = new LineNumberReader(new FileReader(m_basePath + C_OCSETUP_FOLDER + file));
            String line = null;
            String statement = "";
            while(true)  {
                line = reader.readLine();
                if(line==null)break;

                StringTokenizer st = new StringTokenizer(line);

                while (st.hasMoreTokens())  {
                    String currentToken = st.nextToken();

                    /* comment! Skip rest of the line */
                    if (currentToken.startsWith("#")) {
                        break;
                    }

                    /* not to be executed */
                    if (currentToken.startsWith("prompt")) {
                        break;
                    }

                    /* there is an included file */
                    if (currentToken.startsWith("@")) {
                        /* cut of '@' */
                        currentToken = currentToken.substring(1);
                        includedFile = true;
                    }

                    /* add token to query */
                    statement += " " + currentToken;

                    /* query complete (terminated by ';') */
                    if (currentToken.endsWith(";")) {
                        /* cut of ';' at the end */
                        statement = statement.substring(0,(statement.length()-1));

                        /* there is an included File. Get it and execute it */
                        if (includedFile) {
                            if (replacers != null) {
                                ExecuteStatement(replaceValues(getIncludedFile(statement),replacers));
                            }
                            else  {
                                ExecuteStatement(getIncludedFile(statement));
                            }
                            //reset
                            includedFile = false;
                        }
                        /* normal statement. Execute it */
                        else  {
                            if (replacers != null) {
                                ExecuteStatement(replaceValues(statement,replacers));
                            }
                            else  {
                                ExecuteStatement(statement);
                            }
                        }

                        //reset
                        statement = "";
                    }
                }
                statement += " \n";
            }
            reader.close();
        }
        catch (Exception e) {
            if(m_errorLogging)  {
                m_errors.addElement(e.toString() + "\n");
            }
        }
    }

    private String replaceValues(String source, Hashtable replacers)  {
        StringTokenizer tokenizer = new StringTokenizer(source);
        String temp = "";

        while(tokenizer.hasMoreTokens())  {
            String token = tokenizer.nextToken();

            // replace identifier found
            if(token.startsWith("$$") && token.endsWith("$$"))  {

                // look in the hashtable
                Object value = replacers.get(token);

                //found value
                if(value != null) {
                    token = value.toString();
                }
            }
            temp += token + " ";
        }
        return temp;
    }

    public String getConfigFolder() {
        return (m_basePath + "WEB-INF/classes/com/bizwink/cms/server/").replace('\\','/').replace('/',File.separatorChar);
    }

    private String getScript(String key) {
    /* open properties, get the value */
        try {
            Properties properties = new Properties();
            FileInputStream fisdb = new FileInputStream(new File(getConfigFolder()+"dbsetup.properties"));
            properties.load(fisdb);
            //  properties.load(getClass().getClassLoader().getResourceAsStream("com/bizwink/boot/dbsetup.properties"));
            String value = properties.getProperty(key);
            return value;
        }
        catch (Exception e) {
            if(m_errorLogging)  {
                m_errors.addElement(e.toString() + " \n");
            }
            return null;
        }
    }

    private String getIncludedFile(String statement)  {
        String file;
        statement = statement.trim();

        if(statement.startsWith("./"))  {
      /* cut off */
            file = statement.substring(2);
        }
        else if(statement.startsWith("."))  {
      /* cut off */
            file = statement.substring(1);
        }
        else  {
            file = statement;
        }

    /* read and return everything */
        try {
            LineNumberReader reader = new LineNumberReader(new FileReader(m_basePath + C_OCSETUP_FOLDER + file));
            String stat = "";
            String line = null;

            while (true) {
                line = reader.readLine();
                if(line==null)break;
                line = line.trim();
                if(line.startsWith("--") || line.startsWith("/"))  {
                }
                else  {
                    stat += line + " \n";
                }
            }
            reader.close();
            return stat.trim();
        }
        catch (Exception e) {
            if(m_errorLogging)  {
                m_errors.addElement(e.toString() + "\n");
            }
            return null;
        }
    }

    private void ExecuteStatement(String statement)  {
        Statement stat;
        try  {
            stat = m_con.createStatement();
            stat.execute(statement);
            stat.close();
        }
        catch (Exception e)  {
            if(m_errorLogging)  {
                m_errors.addElement(e.toString() + "\n");
            }
        }
    }

    public Vector getErrors() {
        return m_errors;
    }
    public void clearErrors() {
        m_errors.clear();
    }

    public boolean noErrors() {
        return m_errors.isEmpty();
    }

    protected void finalize() {
        try {
            m_con.close();
        }
        catch (SQLException e)  {}
    }
}