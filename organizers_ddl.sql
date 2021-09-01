CREATE TABLE Venues (
    V_ID INT NOT NULL,
    V_Name VARCHAR(100) NOT NULL,
    V_Location VARCHAR(150) NOT NULL,
    V_Capacity INT NOT NULL,
    PRIMARY KEY(V_ID)
);


CREATE TABLE Journalists (
    J_ID INT NOT NULL,
    J_FirstName VARCHAR(30) NOT NULL,
    J_LastName	VARCHAR(30) NOT NULL,
    J_Publication VARCHAR(50) NOT NULL,
    J_Contact	VARCHAR(20) NOT NULL,
    J_NL_Subscription_Status BOOLEAN,
    J_NL_Suscription_ID INT,
    PRIMARY KEY(J_ID)
);


CREATE TABLE Organizers (
    O_ID INT NOT NULL,
    O_FirstName VARCHAR(30) NOT NULL,
    O_LastName	VARCHAR(30) NOT NULL,
    O_Birthdate DATE NOT NULL,
    O_Contact	VARCHAR(20) NOT NULL,
    O_Salary DECIMAL(12,2) NOT NULL,
    O_EmployeeType VARCHAR(10) NOT NULL,
    Supervisor_ID INT,
    E_W_ID INT NOT NULL,
    E_Location VARCHAR(30),
    PRIMARY KEY(O_ID)
);

CREATE TABLE Notifications(
    N_ID INT NOT NULL,
    N_Sender INT NOT NULL,
    N_Content VARCHAR(255) NOT NULL,
    N_Time DATETIME NOT NULL,
    PRIMARY KEY(N_ID)
);

CREATE TABLE Notifications_Recipients(
    N_ID INT NOT NULL,
    N_Recipient_ID INT NOT NULL,
    PRIMARY KEY (N_ID, N_Recipient_ID)
);

CREATE TABLE Employee_Work_type(
    E_W_ID INT NOT NULL,
    E_W_Name VARCHAR(20) NOT NULL,
    PRIMARY KEY(E_W_ID)
);


CREATE TABLE EMPLOYEE_WORK_SHIFT (
    E_S_ID INT NOT NULL,
    E_S_Date DATE NOT NULL,
    E_S_Begin TIME NOT NULL,
    E_S_End TIME NOT NULL,
    E_S_Work VARCHAR(20) NOT NULL,
    PRIMARY KEY(E_S_ID)
);

CREATE TABLE SHIFT_WORKERS (
    S_ID INT NOT NULL,
    E_ID INT NOT NULL,
    PRIMARY KEY (S_ID, E_ID)
)

CREATE TABLE SUPPLY(
    S_ID INT NOT NULL,
    S_Name VARCHAR(20) NOT NULL,
    S_Quantity INT NOT NULL,
    S_PricePerUnit DECIMAL(12,2) NOT NULL,
    S_Available INT NOT NULL,
    PRIMARY KEY(S_ID)
);

CREATE TABLE NEWSLETTER(
    N_IssueNumber INT NOT NULL,
    N_Sold INT NOT NULL,
    N_OnlineReads INT8 NOT NULL,
    PRIMARY KEY(N_IssueNumber)
);

CREATE TABLE POSTS(
    P_ID INT NOT NULL,
    P_Title VARCHAR(50) NOT NULL,
    P_Content TEXT NOT NULL,
    P_N_IssueNumber INT NOT NULL,
    PRIMARY KEY(P_ID)
);


CREATE TABLE TAGS(
    T_Title VARCHAR(20) NOT NULL,
    T_P_ID INT NOT NULL,
    PRIMARY KEY (T_Title, T_P_ID)
);



CREATE TABLE BUDGET (
    B_ID INT NOL NULL,
    B_Travel_Acc DECIMAL(12,2) NOT NULL,
    B_Prizes DECIMAL(12,2) NOT NULL,
    B_Salaries DECIMAL(12,2) NOT NULL,
    B_Telephone DECIMAL(12,2) NOT NULL,
    B_PrINTing DECIMAL(12,2) NOT NULL,
    B_MedicaL DECIMAL(12,2) NOT NULL,
    B_VenueHire DECIMAL(12,2) NOT NULL,
    B_Insurance DECIMAL(12,2) NOT NULL,
    B_Promotion DECIMAL(12,2) NOT NULL,
    B_Transport DECIMAL(12,2) NOT NULL,
    B_EquipmentHire DECIMAL(12,2) NOT NULL,
    PRIMARY KEY(B_ID)
);
