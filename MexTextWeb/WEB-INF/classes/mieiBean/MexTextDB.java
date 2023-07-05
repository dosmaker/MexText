package mieiBean;

import java.lang.invoke.StringConcatException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.sql.*;
import java.text.BreakIterator;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.*;

public class MexTextDB implements java.io.Serializable{
    static private Connection conn = null;
    static private Statement stmt = null;
    private float lat, lon;
    private String nickname, password, email, token, nicknameChat = "", content = "";

    public MexTextDB() {
        String url = "jdbc:mysql://raspberrypi.local:3306/MexText";
        String user = "root";
        String password = "Sciascia1!";

        try {
            conn = DriverManager.getConnection(url, user, password);
            stmt = conn.createStatement();
            System.out.println("Connected to the MySQL database.");
        } catch (SQLException e) {
            System.out.println("Error connecting to the MySQL database: " + e.getMessage());
        }
        create();
    }

    public void setNickname(String nickname){
        this.nickname = nickname;
    }

    public void setPassword(String password){
        this.password = password;
    }

    public void setEmail(String email){
        this.email = email;
    }

    public void setToken(String token){
        this.token = token;
    }

    public void setLat(String lat){
        this.lat = Float.parseFloat(lat);
        try {
            stmt.execute("UPDATE UserMexText SET Lat = "+this.lat+" where Nickname = '"+nickname+"'");
        } catch (SQLException e) {
            // TODO: handle exception
            e.printStackTrace();
        }
    }

    public void setLon(String lon){
        this.lon = Float.parseFloat(lon);
        try {
            stmt.execute("UPDATE UserMexText SET Lon = "+this.lon+" where Nickname = '"+nickname+"'");
        } catch (SQLException e) {
            // TODO: handle exception
            e.printStackTrace();
        }
    }

    public void setNicknameChat(String nicknameChat){
        if(searchUser(nicknameChat)){
            this.nicknameChat = nicknameChat;
        }
    }

    public void setContent(String content){
        this.content = content;
    }

    private void create() {
        try {
            stmt.execute("CREATE TABLE IF NOT EXISTS UserMexText(Nickname VARCHAR(30) PRIMARY KEY NOT NULL, Password TEXT(512) NOT NULL, Email CHAR(50) NOT NULL, Token TEXT(128), Lat FLOAT, Lon FLOAT, Online BOOLEAN, CONSTRAINT unique_id UNIQUE (Email))");
            stmt.execute("CREATE TABLE IF NOT EXISTS Mex(IDMex INT PRIMARY KEY AUTO_INCREMENT, Content TEXT(6000), NicknameSender CHAR(30) REFERENCES UserMexText(Nickname), NicknameReceiver CHAR(30) REFERENCES UserMexText(Nickname))");
        } catch (SQLException exception) {
            exception.printStackTrace();
        }
    }

    public String getRegister(){
        try {
            stmt.execute("INSERT INTO UserMexText(Nickname, Password, Email, Token, Lat, Lon, Online) VALUES ('"+nickname+"', '"+password+"', '"+email+"', null, null, null, false)");
            //close();
            return "true";
        } catch (SQLException e) {
            e.printStackTrace();
            return "false";
        }
    }

    public String getLat(){
        String str = "SELECT Lat FROM UserMexText WHERE Nickname = '"+nickname+"'";
        String latitude = null;
        try {
            ResultSet query = stmt.executeQuery(str);

            if (query.next()) {
                latitude = query.getString(1);
            }

            return latitude;
        } catch (SQLException e) {
            // Handle SQL exceptionse
            e.printStackTrace();
            return latitude;
        }
    }

    public String getLon(){
        String str = "SELECT Lon FROM UserMexText WHERE Nickname = '"+nickname+"'";
        String longitude = null;
        try {
            ResultSet query = stmt.executeQuery(str);

            if (query.next()) {
                longitude = query.getString(1);
            }

            return longitude;
        } catch (SQLException e) {
            // Handle SQL exceptionse
            e.printStackTrace();
            return longitude;
        }
    }

    public String getNicknameChat(){
        return nicknameChat;
    }




    public boolean Login(){
        String str = "SELECT * FROM UserMexText WHERE Nickname = '"+nickname+"' OR Email = '"+nickname+"'";
        String nick = null, pass = null; Boolean on;
        try {
            ResultSet query = stmt.executeQuery(str);

            if(query.next()){
                nick = query.getString("Nickname");
                pass = query.getString("Password");
                on = query.getBoolean("Online");
                nickname = nick;
            }else{
                return false;
            }

            if(nickname.equals(nick) && password.equals(pass) && !on){
                try {
                    boolean y = stmt.execute("UPDATE UserMexText SET Token = NULL WHERE Nickname = '"+nick+"'");
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                return true;
            }else{
                return false;
            }
        } catch (SQLException e) {
            // Handle SQL exceptionse
            e.printStackTrace();
            return false;
        }
    }

    public void online(){
        try {
            stmt.execute("UPDATE UserMexText SET Online = true where Nickname = '"+nickname+"'");           
        } catch (SQLException e) {
            // TODO: handle exception
            e.printStackTrace();
        }
    }

    public void offline(){
        try {
            stmt.execute("UPDATE UserMexText SET Online = false where Nickname = '"+nickname+"'");
        } catch (SQLException e) {
            // TODO: handle exception
            e.printStackTrace();
        }
    }




    /* Forgotten password */
    public void sendEmail(String recipient) throws MessagingException {
        
        // Indirizzo email e password dell'account mittente
        String senderEmail = "mextext.no.reply@gmail.com";
        String senderPassword = "cosplrrcvwjpbuje";
        
        // Configurazione della sessione SMTP
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        
        // Autenticazione
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });
        
        // Creazione del messaggio email
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(senderEmail));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
        message.setSubject("Forgot password or username");

        String str = "SELECT Nickname FROM UserMexText WHERE Email = '"+recipient+"'";
        String nick = "";
        try {
            ResultSet query = stmt.executeQuery(str);

            if (query.next()) {
                nick = query.getString(1);
            }
        } catch (SQLException e) {
            // Handle SQL exceptionse
            e.printStackTrace();
        }

        if(nick != ""){ 
            String token = generateToken();
            try {
                boolean x = stmt.execute("UPDATE UserMexText SET Token = '"+token+"' WHERE Nickname = '"+nick+"'");
                //close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

            message.setText("Your nickname is " + nick + "\n\nLogin in this link to reset your password: http://gameshop.ns0.it/MexTextWeb/ForgotNick-Psw/pswReset.html?token="+token+"");
            
            // Invio del messaggio email
            Transport.send(message);
        }
    }

    private String generateToken() {
        SecureRandom random = new SecureRandom();
        // Genera un valore casuale di 128 bit
        byte[] bytes = new byte[16];
        random.nextBytes(bytes);

        // Converte il valore casuale in una stringa esadecimale
        BigInteger number = new BigInteger(1, bytes);
        String token = number.toString(16);

        // Aggiunge gli zeri iniziali se necessario
        while (token.length() < 32) {
            token = "0" + token;
        }

        return token;
    }

    public String getResetPswd(){
        String str = "SELECT Nickname FROM UserMexText WHERE Token = '"+token+"'";
        String nick = "";
        try {
            ResultSet query = stmt.executeQuery(str);

            if (query.next()) {
                nick = query.getString(1);
            }
        } catch (SQLException e) {
            // Handle SQL exceptionse
            e.printStackTrace();
            return "false";
        }

        if (!nick.equals("")) {
            try {
                boolean x = stmt.execute("UPDATE UserMexText SET Password = '"+password+"' WHERE Nickname = '"+nick+"'");
                boolean y = stmt.execute("UPDATE UserMexText SET Token = NULL WHERE Nickname = '"+nick+"'");
                return "true";
            } catch (SQLException e) {
                e.printStackTrace();
                return "false";
            }
        } else {
            return "false";
        }  
    }




    public void removeCoords(){
        try {
            boolean x = stmt.execute("UPDATE UserMexText SET Lat = NULL, Lon = NULL WHERE Nickname = '"+nickname+"'");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public String getMapsUsers(){
        String str = "SELECT COUNT(*) FROM UserMexText WHERE Lat IS NOT NULL";
        String num = null;
        try {
            ResultSet query = stmt.executeQuery(str);

            if (query.next()) {
                num = query.getString(1);
            }
            return num;
        } catch (SQLException e) {
            // Handle SQL exceptionse
            e.printStackTrace();
            return num;
        }
    }

    public String getMapsLat(int i){
        String str = "SELECT Lat FROM UserMexText WHERE Lat IS NOT NULL AND Nickname != '"+nickname+"' ORDER BY Nickname";
        String lat = null;
        try {
            ResultSet query = stmt.executeQuery(str);

            for(int j = 0; j < i; j++){
                if (query.next()) {
                    lat = query.getString(1);
                }
            }
            return lat;
        } catch (SQLException e) {
            // Handle SQL exceptionse
            e.printStackTrace();
            return lat;
        }
    }

    public String getMapsLon(int i){
        String str = "SELECT Lon FROM UserMexText WHERE Lat IS NOT NULL AND Nickname != '"+nickname+"' ORDER BY Nickname";
        String lon = null;
        try {
            ResultSet query = stmt.executeQuery(str);

            for(int j = 0; j < i; j++){
                if (query.next()) {
                    lon = query.getString(1);
                }
            }
            return lon;
        } catch (SQLException e) {
            // Handle SQL exceptionse
            e.printStackTrace();
            return lon;
        }
    }

    public String getMapsNick(int i){
        String str = "SELECT Nickname FROM UserMexText WHERE Lat IS NOT NULL AND Nickname != '"+nickname+"' ORDER BY Nickname";
        String nick = null;
        try {
            ResultSet query = stmt.executeQuery(str);

            for(int j = 0; j < i; j++){
                if (query.next()) {
                    nick = query.getString(1);
                }
            }
            return nick;
        } catch (SQLException e) {
            // Handle SQL exceptionse
            e.printStackTrace();
            return nick;
        }
    }




    private boolean searchUser(String nickS){
        String str = "SELECT * FROM UserMexText WHERE Nickname = '"+nickS+"'";
        String nick = null;
        try {
            ResultSet query = stmt.executeQuery(str);

            if (query.next()) {
                nick = query.getString(1);
                return true;
            }else{
                return false;
            }
        } catch (SQLException e) {
            // Handle SQL exceptionse
            e.printStackTrace();
            return false;
        }
    }

    public String searchMessage(){
        String text = null;
        if(!nicknameChat.equals("")){
            String str = "SELECT Content, IDMex FROM Mex WHERE NicknameReceiver = '"+nickname+"' AND NicknameSender = '"+nicknameChat+"'";
            try {
                ResultSet query = stmt.executeQuery(str);

                if (query.next()) {
                    text = query.getString(1);
                    try {
                        stmt.execute("DELETE FROM Mex WHERE IDMex = "+query.getInt(2)+"");           
                    } catch (SQLException e) {
                        // TODO: handle exception
                        e.printStackTrace();
                    }
                }
                return text;
            } catch (SQLException e) {
                // Handle SQL exceptionse
                e.printStackTrace();
                return text;
            }
        }else{
            return text;
        }
    }

    public void sendMessage(){
        if(!content.equals("") && nickname != null && !nicknameChat.equals("")){
            try {
                stmt.execute("INSERT INTO `Mex`(`Content`, `NicknameSender`, `NicknameReceiver`) VALUES ('"+content+"','"+nickname+"','"+nicknameChat+"')");
            } catch (SQLException e) {
                // TODO: handle exception
                e.printStackTrace();
            }
        }
    }
}