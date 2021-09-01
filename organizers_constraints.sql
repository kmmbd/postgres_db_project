ALTER TABLE Notifications_Recipients
ADD CONSTRAINT fk_nr_1
FOREIGN KEY  (N_ID)
REFERENCES Notifications(N_ID);

ALTER TABLE Notifications_Recipients
ADD CONSTRAINT fk_nr_2
FOREIGN KEY  (N_Recipient_ID)
REFERENCES Organizers(O_ID);

ALTER TABLE Notifications
ADD CONSTRAINT fk_n_1
FOREIGN KEY  (N_Sender)
REFERENCES Organizers(S_ID);

ALTER TABLE Organizers
ADD CONSTRAINT fk_o_1
FOREIGN KEY  (E_W_ID)
REFERENCES Employee_Work_type(E_W_ID);

ALTER TABLE EMPLOYEE_WORK_SHIFT
ADD CONSTRAINT fk_esw_1
FOREIGN KEY  (E_S_Work)
REFERENCES Employee_Work_type(E_W_Name);

ALTER TABLE SHIFT_WORKERS
ADD CONSTRAINT fk_sw_1
FOREIGN KEY  (S_ID)
REFERENCES EMPLOYEE_WORK_SHIFT(E_S_ID);

ALTER TABLE SHIFT_WORKERS
ADD CONSTRAINT fk_sw_2
FOREIGN KEY  (E_ID)
REFERENCES Organizers(O_ID);

ALTER TABLE POSTS
ADD CONSTRAINT fk_p_1
FOREIGN KEY  (P_N_IssueNumber)
REFERENCES NEWSLETTER(N_IssueNumber);

ALTER TABLE TAGS
ADD CONSTRAINT fk_t_1
FOREIGN KEY  (T_P_ID)
REFERENCES POSTS(P_ID);

CREATE INDEX
ON TAGS ((lower(T_Title)));

CREATE INDEX idx_posts
ON POSTS (P_N_IssueNumber);

CREATE INDEX idx_supply
ON SUPPLY ((lower(S_Name)));

CREATE INDEX idx_shift_date
ON EMPLOYEE_WORK_SHIFT (E_S_Date);

CREATE INDEX idx_supervisors
ON Organizers (Supervisor_ID);

ALTER TABLE SUPPLY
ADD CONSTRAINT quantity_check
CHECK (
  S_Available >= 0
  AND S_Quantity >= S_Available
);
