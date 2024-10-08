MERGE INTO DDWH02_DM_MA.TFCT_TRCK_TRUCKS TRG USING
  (SELECT SRC.TRCK_CD_PLANT_CD TRCK_CD_PLANT_CD,
          NULL TRCK_ID_TRCK,
               SRC.TRCK_ID_TRCK_YEAR_MONTH TRCK_ID_TRCK_YEAR_MONTH,
               SRC.TRCK_ID_TRUCK_TRANSIT TRCK_ID_TRCK_TRANSIT,
               SRC.TRCK_CD_TRANSIT_ID TRCK_CD_TRANSIT_ID,
               SRC.IDNH_ID_INB_DLVR_NT_HEAD TRCK_ID_IDNH_DLVR_NT,
               SRC.IDNH_CD_DLVR_NT TRCK_CD_DLVR_NT,
               SRC.IDNH_ID_SUMD_DLVR_NT_STU TRCK_ID_STAT_DLVR_NT_STU,
               SRC.IDNH_CD_DLVR_NT_STU TRCK_CD_DLVR_NOTES_STU,
               SRC.TRCK_ID_TTMD_TRCK_TP TRCK_ID_TRTP_TRCK_TP,
               SRC.TRCK_CD_TRCK_TP TRCK_CD_TRCK_TP,
               SRC.TRCK_ID_TIME_ARRIVAL_DT TRCK_ID_TIME_ARRIVAL_DT,
               SRC.TRCK_DT_ARRIVAL_DT TRCK_DT_ARRIVAL_DT,
               SRC.TRCK_ID_TIME_CHK_IN_DT TRCK_ID_TIME_CHK_IN_DT,
               SRC.TRCK_DT_CHK_IN_DT TRCK_DT_CHK_IN_DT,
               SRC.TRCK_ID_TIME_STR_UNLOAD_DT TRCK_ID_TIME_STR_UNLOAD_DT,
               SRC.TRCK_DT_STR_UNLOAD_DT TRCK_DT_STR_UNLOAD_DT,
               SRC.TRCK_ID_TIME_END_UNLOAD_DT TRCK_ID_TIME_END_UNLOAD_DT,
               SRC.TRCK_DT_END_UNLOAD_DT TRCK_DT_END_UNLOAD_DT,
               SRC.TRCK_ID_TIME_CHK_OUT_DT TRCK_ID_TIME_CHK_OUT_DT,
               SRC.TRCK_DT_CHK_OUT_DT TRCK_DT_CHK_OUT_DT,
               SRC.TRCK_ID_TIME_CMPLTD_RCV_DT TRCK_ID_TIME_CMPLTD_RCV_DT,
               SRC.TRCK_DT_CMPLTD_RCV_DT TRCK_DT_CMPLTD_RCV_DT,
               SRC.TRCK_CD_SITE TRCK_CD_SITE,
               SRC.TRCK_CD_PLATE TRCK_CD_PLATE,
               SRC.TRCK_NR_LT_PHASE_1 TRCK_NR_LT_PHASE_1,
               SRC.TRCK_NR_LT_PHASE_2 TRCK_NR_LT_PHASE_2,
               SRC.TRCK_NR_LT_PHASE_3 TRCK_NR_LT_PHASE_3,
               SRC.TRCK_NR_LT_PHASE_4 TRCK_NR_LT_PHASE_4,
               SRC.TRCK_NR_LT_PHASE_5 TRCK_NR_LT_PHASE_5,
               SRC.TRCK_QT_DLVR_NOTES_RCVD TRCK_QT_DLVR_NOTES_RCVD,
               SRC.TRCK_QT_DLVR_NOTES_CMPLTD TRCK_QT_DLVR_NOTES_CMPLTD,
               SRC.TRCK_FL_HEADER_DETAIL TRCK_FL_HEADER_DETAIL,
               NVL (P_ELT_ID_BATCH, N_ELT_ID_JOB_LOG) TRCK_ID_BATCH_ID,
               SRC.TRCK_CD_SOURCE_SYSTEM TRCK_CD_SOURCE_SYSTEM
   FROM
     (SELECT TRCK_CD_PLANT_CD,
             TRUNC (MONTHS_BETWEEN (TRCK_DT_ARRIVAL_DT, TO_DATE ('2000-01-01', 'YYYY-MM-DD'))) +100 AS TRCK_ID_TRCK_YEAR_MONTH,
             TRCK_ID_TRUCK_TRANSIT,
             TRCK_CD_TRANSIT_ID,
             -2 AS IDNH_ID_INB_DLVR_NT_HEAD,
             DDWH02_DM_MA.FUNC_NOT_AVAILABLE () AS IDNH_CD_DLVR_NT,
             -2 AS IDNH_ID_SUMD_DLVR_NT_STU,
             DDWH02_DM_MA.FUNC_NOT_AVAILABLE () AS IDNH_CD_DLVR_NT_STU,
             TRCK_ID_TTMD_TRCK_TP,
             TRCK_CD_TRCK_TP,
             TO_NUMBER (TO_CHAR (TRCK_DT_ARRIVAL_DT, 'J')) TRCK_ID_TIME_ARRIVAL_DT,
             TRCK_DT_ARRIVAL_DT,
             TO_NUMBER (TO_CHAR (TRCK_DT_CHK_IN_DT, 'J')) TRCK_ID_TIME_CHK_IN_DT,
             TRCK_DT_CHK_IN_DT,
             TO_NUMBER (TO_CHAR (TRCK_DT_STR_UNLOAD_DT, 'J')) TRCK_ID_TIME_STR_UNLOAD_DT,
             TRCK_DT_STR_UNLOAD_DT,
             TO_NUMBER (TO_CHAR (TRCK_DT_END_UNLOAD_DT, 'J')) TRCK_ID_TIME_END_UNLOAD_DT,
             TRCK_DT_END_UNLOAD_DT,
             TO_NUMBER (TO_CHAR (TRCK_DT_CHK_OUT_DT, 'J')) TRCK_ID_TIME_CHK_OUT_DT,
             TRCK_DT_CHK_OUT_DT,
             -2 TRCK_ID_TIME_CMPLTD_RCV_DT,
             NULL AS TRCK_DT_CMPLTD_RCV_DT,
             NVL (TRCK_CD_SITE, DDWH02_DM_MA.FUNC_NOT_AVAILABLE ()) TRCK_CD_SITE,
             NVL (TRCK_CD_PLATE, DDWH02_DM_MA.FUNC_NOT_AVAILABLE ()) TRCK_CD_PLATE,
             ROUND ((TT_TRCK_TRUCK_TRANSIT.TRCK_DT_CHK_IN_DT - TT_TRCK_TRUCK_TRANSIT.TRCK_DT_ARRIVAL_DT) *1440) TRCK_NR_LT_PHASE_1,
             ROUND ((TT_TRCK_TRUCK_TRANSIT.TRCK_DT_STR_UNLOAD_DT - TT_TRCK_TRUCK_TRANSIT.TRCK_DT_CHK_IN_DT) *1440) TRCK_NR_LT_PHASE_2,
             ROUND ((TT_TRCK_TRUCK_TRANSIT.TRCK_DT_END_UNLOAD_DT - TT_TRCK_TRUCK_TRANSIT.TRCK_DT_STR_UNLOAD_DT) *1440) TRCK_NR_LT_PHASE_3,
             ROUND ((TT_TRCK_TRUCK_TRANSIT.TRCK_DT_CHK_OUT_DT - TT_TRCK_TRUCK_TRANSIT.TRCK_DT_END_UNLOAD_DT) *1440) TRCK_NR_LT_PHASE_4,
             NULL TRCK_NR_LT_PHASE_5,

        (SELECT COUNT (DISTINCT TT_IDNH_INB_DLVR_NT_HEAD.IDNH_ID_INB_DLVR_NT_HEAD)
         FROM DDWH01_DW_MA.TT_IDNH_INB_DLVR_NT_HEAD TT_IDNH_INB_DLVR_NT_HEAD
         WHERE TT_IDNH_INB_DLVR_NT_HEAD.IDNH_ID_TRCK_TRANSIT_ID = TT_TRCK_TRUCK_TRANSIT.TRCK_ID_TRUCK_TRANSIT
           AND TT_IDNH_INB_DLVR_NT_HEAD.IDNH_CD_PLANT_CD = P_ELT_CD_PLANT ) TRCK_QT_DLVR_NOTES_RCVD,

        (SELECT COUNT (DISTINCT TT_IDNH_INB_DLVR_NT_HEAD.IDNH_ID_INB_DLVR_NT_HEAD)
         FROM DDWH01_DW_MA.TT_IDNH_INB_DLVR_NT_HEAD TT_IDNH_INB_DLVR_NT_HEAD
         WHERE TT_IDNH_INB_DLVR_NT_HEAD.IDNH_CD_DLVR_NT_STU='CHIUSA'
           AND TT_IDNH_INB_DLVR_NT_HEAD.IDNH_ID_TRCK_TRANSIT_ID=TT_TRCK_TRUCK_TRANSIT.TRCK_ID_TRUCK_TRANSIT
           AND TT_IDNH_INB_DLVR_NT_HEAD.IDNH_CD_PLANT_CD = P_ELT_CD_PLANT ) TRCK_QT_DLVR_NOTES_CMPLTD,
                  'H' TRCK_FL_HEADER_DETAIL,
                      TRCK_CD_SOURCE_SYSTEM
      FROM
        (SELECT *
         FROM DDWH01_DW_MA.TT_TRCK_TRUCK_TRANSIT
         WHERE TRCK_CD_PLANT_CD = P_ELT_CD_PLANT ) TT_TRCK_TRUCK_TRANSIT
      UNION ALL SELECT IDNH.IDNH_CD_PLANT_CD,
                       TRUNC (MONTHS_BETWEEN (TRCK_DT_ARRIVAL_DT, TO_DATE ('2000-01-01', 'YYYY-MM-DD'))) +100 TRCK_ID_TRCK_YEAR_MONTH,
                       TRCK.TRCK_ID_TRUCK_TRANSIT,
                       TRCK.TRCK_CD_TRANSIT_ID,
                       IDNH.IDNH_ID_INB_DLVR_NT_HEAD,
                       IDNH.IDNH_CD_DLVR_NT,
                       IDNH.IDNH_ID_SUMD_DLVR_NT_STU,
                       IDNH.IDNH_CD_DLVR_NT_STU,
                       TRCK.TRCK_ID_TTMD_TRCK_TP,
                       TRCK.TRCK_CD_TRCK_TP,
                       TO_NUMBER (TO_CHAR (TRCK_DT_ARRIVAL_DT, 'J')) TRCK_ID_TIME_ARRIVAL_DT,
                       TRCK.TRCK_DT_ARRIVAL_DT,
                       TO_NUMBER (TO_CHAR (TRCK_DT_CHK_IN_DT, 'J')) TRCK_ID_TIME_CHK_IN_DT,
                       TRCK.TRCK_DT_CHK_IN_DT,
                       TO_NUMBER (TO_CHAR (TRCK_DT_STR_UNLOAD_DT, 'J')) TRCK_ID_TIME_STR_UNLOAD_DT,
                       TRCK_DT_STR_UNLOAD_DT,
                       TO_NUMBER (TO_CHAR (TRCK_DT_END_UNLOAD_DT, 'J')) TRCK_ID_TIME_END_UNLOAD_DT,
                       TRCK.TRCK_DT_END_UNLOAD_DT,
                       TO_NUMBER (TO_CHAR (TRCK_DT_CHK_OUT_DT, 'J')) TRCK_ID_TIME_CHK_OUT_DT,
                       TRCK.TRCK_DT_CHK_OUT_DT,
                       NVL (TO_NUMBER (TO_CHAR (INDN.MAKS, 'J')), -2) TRCK_ID_TIME_CMPLTD_RCV_DT,
                       INDN.MAKS TRCK_DT_CMPLTD_RCV_DT,
                       NVL (TRCK_CD_SITE, DDWH02_DM_MA.FUNC_NOT_APPLICABLE_CODE ()) TRCK_CD_SITE,
                       NVL (TRCK_CD_PLATE, DDWH02_DM_MA.FUNC_NOT_APPLICABLE_CODE ()) TRCK_CD_PLATE,
                       ROUND ((TRCK.TRCK_DT_CHK_IN_DT - TRCK.TRCK_DT_ARRIVAL_DT) *1440) TRCK_NR_LT_PHASE_1,
                       ROUND ((TRCK.TRCK_DT_STR_UNLOAD_DT - TRCK.TRCK_DT_CHK_IN_DT) *1440) TRCK_NR_LT_PHASE_2,
                       ROUND ((TRCK.TRCK_DT_END_UNLOAD_DT - TRCK.TRCK_DT_STR_UNLOAD_DT) *1440) TRCK_NR_LT_PHASE_3,
                       ROUND ((TRCK.TRCK_DT_CHK_OUT_DT - TRCK.TRCK_DT_END_UNLOAD_DT) *1440) TRCK_NR_LT_PHASE_4,
                       ROUND ((INDN.MAKS - TRCK.TRCK_DT_END_UNLOAD_DT) *1440) TRCK_NR_LT_PHASE_5,
                       COUNT (*) OVER (PARTITION BY TRCK.TRCK_CD_TRANSIT_ID) TRCK_QT_DLVR_NOTES_RCVD,

        (SELECT COUNT (DISTINCT TT_IDNH_INB_DLVR_NT_HEAD.IDNH_ID_INB_DLVR_NT_HEAD)
         FROM DDWH01_DW_MA.TT_IDNH_INB_DLVR_NT_HEAD TT_IDNH_INB_DLVR_NT_HEAD
         WHERE TT_IDNH_INB_DLVR_NT_HEAD.IDNH_CD_DLVR_NT_STU='CHIUSA'
           AND TT_IDNH_INB_DLVR_NT_HEAD.IDNH_ID_TRCK_TRANSIT_ID=TRCK_ID_TRUCK_TRANSIT
           AND TT_IDNH_INB_DLVR_NT_HEAD.IDNH_CD_PLANT_CD = P_ELT_CD_PLANT ) TRCK_QT_DLVR_NOTES_CMPLTD,
                                      'D' TRCK_FL_HEADER_DETAIL,
                                          TRCK_CD_SOURCE_SYSTEM
      FROM
        (SELECT *
         FROM DDWH01_DW_MA.TT_TRCK_TRUCK_TRANSIT
         WHERE TRCK_CD_PLANT_CD = P_ELT_CD_PLANT ) TRCK,

        (SELECT *
         FROM DDWH01_DW_MA.TT_IDNH_INB_DLVR_NT_HEAD
         WHERE IDNH_CD_PLANT_CD = P_ELT_CD_PLANT ) IDNH,

        (SELECT MAX (INDN_DT_DLVR_NT_LN_CLOSE_DT) MAKS,
                    INDN_ID_IDNH_DLVR_NT,
                    INDN_CD_PLANT_CD
         FROM DDWH01_DW_MA.TD_INDN_INB_DLVR_NT
         WHERE INDN_CD_PLANT_CD = P_ELT_CD_PLANT
         GROUP BY INDN_ID_IDNH_DLVR_NT,
                  INDN_CD_PLANT_CD
         HAVING MAX (INDN_CD_DLVR_NT_LN_STU) = 'CHIUSA'
         AND MIN (INDN_CD_DLVR_NT_LN_STU) = 'CHIUSA') INDN
      WHERE 1=1
        AND IDNH.IDNH_ID_TRCK_TRANSIT_ID = TRCK.TRCK_ID_TRUCK_TRANSIT
        AND INDN.INDN_ID_IDNH_DLVR_NT (+) = IDNH.IDNH_ID_INB_DLVR_NT_HEAD ) SRC,

     (SELECT *
      FROM DDWH02_DM_MA.TW_TRCK_TRUCKS_KEY
      WHERE TRCK_CD_PLANT_CD = P_ELT_CD_PLANT ) DELTA
   WHERE 1=1
     AND DELTA.TRCK_CD_TRANSIT_ID = SRC.TRCK_CD_TRANSIT_ID ) QRY ON (TRG.TRCK_CD_PLANT_CD = QRY.TRCK_CD_PLANT_CD
                                                                     AND TRG.TRCK_CD_TRANSIT_ID = QRY.TRCK_CD_TRANSIT_ID
                                                                     AND TRG.TRCK_CD_DLVR_NT = QRY.TRCK_CD_DLVR_NT) WHEN MATCHED THEN
UPDATE
SET TRG.TRCK_ID_TRCK= DDWH02_DM_MA.SEQ_TRCK_TFCT01.NEXTVAL,
    TRG.TRCK_ID_TRCK_YEAR_MONTH= QRY.TRCK_ID_TRCK_YEAR_MONTH,
    TRG.TRCK_ID_TRCK_TRANSIT= QRY.TRCK_ID_TRCK_TRANSIT,
    TRG.TRCK_ID_IDNH_DLVR_NT= QRY.TRCK_ID_IDNH_DLVR_NT,
    TRG.TRCK_ID_STAT_DLVR_NT_STU= QRY.TRCK_ID_STAT_DLVR_NT_STU,
    TRG.TRCK_CD_DLVR_NOTES_STU= QRY.TRCK_CD_DLVR_NOTES_STU,
    TRG.TRCK_ID_TRTP_TRCK_TP= QRY.TRCK_ID_TRTP_TRCK_TP,
    TRG.TRCK_CD_TRCK_TP= QRY.TRCK_CD_TRCK_TP,
    TRG.TRCK_ID_TIME_ARRIVAL_DT= QRY.TRCK_ID_TIME_ARRIVAL_DT,
    TRG.TRCK_DT_ARRIVAL_DT= QRY.TRCK_DT_ARRIVAL_DT,
    TRG.TRCK_ID_TIME_CHK_IN_DT= QRY.TRCK_ID_TIME_CHK_IN_DT,
    TRG.TRCK_DT_CHK_IN_DT= QRY.TRCK_DT_CHK_IN_DT,
    TRG.TRCK_ID_TIME_STR_UNLOAD_DT= QRY.TRCK_ID_TIME_STR_UNLOAD_DT,
    TRG.TRCK_DT_STR_UNLOAD_DT= QRY.TRCK_DT_STR_UNLOAD_DT,
    TRG.TRCK_ID_TIME_END_UNLOAD_DT= QRY.TRCK_ID_TIME_END_UNLOAD_DT,
    TRG.TRCK_DT_END_UNLOAD_DT= QRY.TRCK_DT_END_UNLOAD_DT,
    TRG.TRCK_ID_TIME_CHK_OUT_DT= QRY.TRCK_ID_TIME_CHK_OUT_DT,
    TRG.TRCK_DT_CHK_OUT_DT= QRY.TRCK_DT_CHK_OUT_DT,
    TRG.TRCK_ID_TIME_CMPLTD_RCV_DT= QRY.TRCK_ID_TIME_CMPLTD_RCV_DT,
    TRG.TRCK_DT_CMPLTD_RCV_DT= QRY.TRCK_DT_CMPLTD_RCV_DT,
    TRG.TRCK_CD_SITE= QRY.TRCK_CD_SITE,
    TRG.TRCK_CD_PLATE= QRY.TRCK_CD_PLATE,
    TRG.TRCK_NR_LT_PHASE_1= QRY.TRCK_NR_LT_PHASE_1,
    TRG.TRCK_NR_LT_PHASE_2= QRY.TRCK_NR_LT_PHASE_2,
    TRG.TRCK_NR_LT_PHASE_3= QRY.TRCK_NR_LT_PHASE_3,
    TRG.TRCK_NR_LT_PHASE_4= QRY.TRCK_NR_LT_PHASE_4,
    TRG.TRCK_NR_LT_PHASE_5= QRY.TRCK_NR_LT_PHASE_5,
    TRG.TRCK_QT_DLVR_NOTES_RCVD= QRY.TRCK_QT_DLVR_NOTES_RCVD,
    TRG.TRCK_QT_DLVR_NOTES_CMPLTD= QRY.TRCK_QT_DLVR_NOTES_CMPLTD,
    TRG.TRCK_FL_HEADER_DETAIL= QRY.TRCK_FL_HEADER_DETAIL,
    TRG.TRCK_ID_BATCH_ID= QRY.TRCK_ID_BATCH_ID,
    TRG.TRCK_CD_SOURCE_SYSTEM= QRY.TRCK_CD_SOURCE_SYSTEM,
    TRG.TRCK_CD_OPERATOR_CODE= 'ETL',
    TRG.TRCK_DT_INS_ROW= SYSDATE,
    TRG.TRCK_DT_UPD_ROW= SYSDATE WHEN NOT MATCHED THEN
INSERT (TRCK_CD_PLANT_CD,
        TRCK_ID_TRCK,
        TRCK_ID_TRCK_YEAR_MONTH,
        TRCK_ID_TRCK_TRANSIT,
        TRCK_CD_TRANSIT_ID,
        TRCK_ID_IDNH_DLVR_NT,
        TRCK_CD_DLVR_NT,
        TRCK_ID_STAT_DLVR_NT_STU,
        TRCK_CD_DLVR_NOTES_STU,
        TRCK_ID_TRTP_TRCK_TP,
        TRCK_CD_TRCK_TP,
        TRCK_ID_TIME_ARRIVAL_DT,
        TRCK_DT_ARRIVAL_DT,
        TRCK_ID_TIME_CHK_IN_DT,
        TRCK_DT_CHK_IN_DT,
        TRCK_ID_TIME_STR_UNLOAD_DT,
        TRCK_DT_STR_UNLOAD_DT,
        TRCK_ID_TIME_END_UNLOAD_DT,
        TRCK_DT_END_UNLOAD_DT,
        TRCK_ID_TIME_CHK_OUT_DT,
        TRCK_DT_CHK_OUT_DT,
        TRCK_ID_TIME_CMPLTD_RCV_DT,
        TRCK_DT_CMPLTD_RCV_DT,
        TRCK_CD_SITE,
        TRCK_CD_PLATE,
        TRCK_NR_LT_PHASE_1,
        TRCK_NR_LT_PHASE_2,
        TRCK_NR_LT_PHASE_3,
        TRCK_NR_LT_PHASE_4,
        TRCK_NR_LT_PHASE_5,
        TRCK_QT_DLVR_NOTES_RCVD,
        TRCK_QT_DLVR_NOTES_CMPLTD,
        TRCK_FL_HEADER_DETAIL,
        TRCK_ID_BATCH_ID,
        TRCK_CD_SOURCE_SYSTEM,
        TRCK_CD_OPERATOR_CODE,
        TRCK_DT_INS_ROW,
        TRCK_DT_UPD_ROW)
VALUES (QRY.TRCK_CD_PLANT_CD, DDWH02_DM_MA.SEQ_TRCK_TFCT01.NEXTVAL, QRY.TRCK_ID_TRCK_YEAR_MONTH, QRY.TRCK_ID_TRCK_TRANSIT, QRY.TRCK_CD_TRANSIT_ID, QRY.TRCK_ID_IDNH_DLVR_NT, QRY.TRCK_CD_DLVR_NT, QRY.TRCK_ID_STAT_DLVR_NT_STU, QRY.TRCK_CD_DLVR_NOTES_STU, QRY.TRCK_ID_TRTP_TRCK_TP, QRY.TRCK_CD_TRCK_TP, QRY.TRCK_ID_TIME_ARRIVAL_DT, QRY.TRCK_DT_ARRIVAL_DT, QRY.TRCK_ID_TIME_CHK_IN_DT, QRY.TRCK_DT_CHK_IN_DT, QRY.TRCK_ID_TIME_STR_UNLOAD_DT, QRY.TRCK_DT_STR_UNLOAD_DT, QRY.TRCK_ID_TIME_END_UNLOAD_DT, QRY.TRCK_DT_END_UNLOAD_DT, QRY.TRCK_ID_TIME_CHK_OUT_DT, QRY.TRCK_DT_CHK_OUT_DT, QRY.TRCK_ID_TIME_CMPLTD_RCV_DT, QRY.TRCK_DT_CMPLTD_RCV_DT, QRY.TRCK_CD_SITE, QRY.TRCK_CD_PLATE, QRY.TRCK_NR_LT_PHASE_1, QRY.TRCK_NR_LT_PHASE_2, QRY.TRCK_NR_LT_PHASE_3, QRY.TRCK_NR_LT_PHASE_4, QRY.TRCK_NR_LT_PHASE_5, QRY.TRCK_QT_DLVR_NOTES_RCVD, QRY.TRCK_QT_DLVR_NOTES_CMPLTD, QRY.TRCK_FL_HEADER_DETAIL, QRY.TRCK_ID_BATCH_ID, QRY.TRCK_CD_SOURCE_SYSTEM, 'ETL', SYSDATE, SYSDATE)