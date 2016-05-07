package comp9120;
/*
 * Example JDBC client for University Registration DB
 * Skeleton Java program for COMP9120 Database Application Programming lecture/tutorial
 * Make sure you have added an appropriate Oracle JDBC driver library
 */
import java.sql.*;

public class UniDbClient {
    // connection parameters
    private final String userid   = "jloc8749";
    private final String passwd   = "jloc8749";
    private final String database = "oracle12.it.usyd.edu.au:1521:COMP5138";

    // instance variable for the database connection   
    private Connection conn = null; 
    
    /**
     * class constructor 
     * which loads the Oracle JDBC driver
     */
    UniDbClient ()
    {
       try 
       {   
           /* load Oracle's JDBC driver */
           Class.forName ("oracle.jdbc.driver.OracleDriver");
       }
       catch (ClassNotFoundException no_class_ex) 
       {  
           /* error handling when no JDBC class is found */
           System.out.println(no_class_ex);
       }
    }
    
    /**
     * Establishes a connection to the Oracle database.
     * The connection parameters are read from the instance variables above
     * (userid, passwd, and database).
     * @returns  true   on success and then the instance variable 'conn' 
     *                  holds an open connection to the database.
     *           false  otherwise
     */ 
    public boolean connectToDatabase ()
    {
       try 
       {   
           /* connect to the database */
           conn = DriverManager.getConnection("jdbc:oracle:thin:@"+database,userid,passwd);
           /* If you want to connect to your own database you should remove this line: */
           //conn.createStatement().execute("ALTER SESSION SET current_schema=COMP5138_DEMO");
           return true;
       }
       catch (SQLException sql_ex) 
       {  
           /* error handling */
           System.out.println(sql_ex);
           return false;
       }
    }
        
    /**
     * open ONE single database connection
     */
    public boolean openConnection ()
    {
        boolean retval = true;
        
        if ( conn != null )
            System.err.println("You are already connected to Oracle; no second connection is needed!");
        else {
            if ( connectToDatabase() )
                System.out.println("You successfully connected to Oracle.");
            else {
                System.out.println("Oops - something went wrong.");
                retval = false;
            }
        }
        
        return retval;
    }

    /**
     * close the database connection again
     */
    public void closeConnection ()
    {
        if ( conn == null )
            System.err.println("You are not connected to Oracle!");
        else try
        {
             conn.close(); // close the connection again after usage! 
             conn = null;
        }
        catch (SQLException sql_ex) 
        {  /* error handling */
             System.out.println(sql_ex);
        }
    }
    
    

    /**
     * Example Function, Exercise 2:
     * Lists on the screen all course offerings ascending by uos_Code
     * including all semesters when the course is offered.
     *
     * Assumes that we are already connected to the database
     */
    public void listUnits ()
    {
       try
       {
    	  Connection mycon = DriverManager.getConnection("jdbc:oracle:thin:@"+database,userid,passwd);
          /* prepare a static query statement */
          Statement stmt = mycon.createStatement();
          // Change this query to return the right results
          String query = "";
     
          /* execute the query and loop through the resultset */
          ResultSet rset = stmt.executeQuery(query); 
          int nr = 0;
          while ( rset.next() )
          {
             nr++;
          }
              
          if ( nr == 0 )
             System.out.println("No entries found.");
          else
             System.out.println("Retrieved " + nr + " records.");   
          /* clean up! (NOTE this really belongs in a finally{} block) */
          stmt.close();
       }
       catch (SQLException sqle) 
       {  
           /* error handling */
           System.out.println("SQLException : " + sqle);
       }
    }
    
          
    /**
     * Exercise 3:
     * Display the transcript of a specific student
     */
    public void listTranscript ( int studentID )
    {
    /* INSERT YOUR CODE HERE */
    	String query = "select * from Transcript where studId = ?";

    	try {
    		//Connection mycon = DriverManager.getConnection("jdbc:oracle:thin:@"+database,userid,passwd);
    		
    		PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setInt(1, studentID);
	    	
	    	ResultSet rset = stmt.executeQuery(); 
	        int nr = 1;
	        while ( rset.next() ){
	      	  System.out.println(Integer.toString(nr)+": "+rset.getString("uoSCode")+" was taken with a grade of "+rset.getString("grade"));
	           nr++;
	        } 
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }   
    public void callProcedure(int STUID){

    	CallableStatement cs = null;
    	try {
    		cs = conn.prepareCall("{ call CALLMESA7 (?,?)}");
    		//cs = conn.prepareCall("{ ? := call CALLMESA6 (?)");
    		cs.setInt (1, STUID);
    		cs.registerOutParameter (2, Types.VARCHAR);
			ResultSet rs = cs.executeQuery();
			while ( rs.next() ){
		      	  System.out.println(rs.getString("UCODE"));
		        } 
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }
    public void createProcedure(){
    	String createProcedure = ""+
    "CREATE PROCEDURE list_transcript("+
    "IN STUID INTEGER,"+
    "OUT UCODE CHAR(8))"+
    "begin" +
    "select uoSCode into UCODE" +
    "from Transcript"+
    "where studId = STUID"+
    "end";
    	Statement stmt = null;
    	
        try {
        	stmt = conn.createStatement();
			stmt.executeUpdate(createProcedure);
		} catch (SQLException e) {
			e.printStackTrace();
		}
    }
    
    
    /**
     * Main program.
     */
    public static void main ( String[] args )
    {
       // create our actual client and test the database connection
       UniDbClient uniDB = new UniDbClient();

       if ( uniDB.openConnection() ) {
           //uniDB.listUnits();
           
           //uniDB.listTranscript(305678453);
    	   //uniDB.createProcedure();
    	   uniDB.callProcedure(305678453);
    	   
           uniDB.closeConnection();
        }
    }
}