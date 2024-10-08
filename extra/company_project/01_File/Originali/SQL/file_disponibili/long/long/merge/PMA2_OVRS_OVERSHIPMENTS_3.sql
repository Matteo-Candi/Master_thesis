MERGE INTO DDWH02_DM_MA.TFCT_OVRS_OVERSHIPMENTS TRG USING
  (SELECT OVRS_CD_PLANT_CD,
          OVRS_ID_OVRS,
          OVRS_ID_TIME_RECEPT_DT,
          OVRS_ID_TIME_REQ_DLVR_DT,
          OVRS_ID_TIME_LAST_REC_DT,
          OVRS_ID_TIME_PRVS_REC_DT,
          OVRS_ID_VEND_ID,
          OVRS_CD_VENDOR,
          OVRS_ID_STRL_STORAGE_LOC,
          OVRS_CD_STORAGE_LOC,
          OVRS_ID_MTRL_MATERIAL_ID,
          OVRS_CD_MATERIAL,
          OVRS_CD_PURCH_ORD,
          OVRS_CD_PURCH_ORD_LN,
          OVRS_CD_SEQ_ID,
          OVRS_CD_SCHED_LN_ID,
          OVRS_CD_RELEASE_NBR,
          OVRS_CD_MAT_DOC_ID,
          OVRS_QT_CUM_DLVR_NT_QTY,
          OVRS_QT_REQ_QTY,
          OVRS_QT_RCVD_QTY,
          OVRS_QT_OVERSHIPMENT,
          OVRS_FL_OVERSHIPMENT_MARKER,
          OVRS_CS_TOT_MANUF_COST,
          OVRS_AM_OVERSHIPMENT,
          OVRS_NR_DAYS_OF_OVERSHIPMENT,
          OVRS_FL_DAYS_OF_OVERSHIPMENT,
          OVRS_NR_DAYS_OF_PASTDUE,
          OVRS_FL_DAYS_OF_PASTDUE,
          OVRS_PC_OVERDLVR_LIMIT,
          OVRS_FL_TOLERANCE_LIMIT,
          OVRS_CD_SUPPL_DLVR_NT,
          OVRS_FL_SUBCTR_MARK,
          OVRS_CD_PROD_ORD,
          OVRS_CD_OP_SUBSTR,
          OVRS_AM_OVERSHIPMENT_DAYS,
          OVRS_QT_PREV_CUM_REQ_QTY,
          OVRS_QT_PREV_CUM_REC_QTY,
          OVRS_QT_PREV_BALANC_QTY,
          OVRS_ID_BATCH_ID,
          OVRS_CD_SOURCE_SYSTEM,
          OVRS_DT_INS_ROW,
          OVRS_DT_UPD_ROW,
          OVRS_CD_OPERATOR_CODE
   FROM
     (SELECT OVRS_CD_PLANT_CD,
             OVRS_ID_OVRS,
             NVL (OVRS_ID_TIME_RECEPT_DT, -2) AS OVRS_ID_TIME_RECEPT_DT,
             NVL (OVRS_ID_TIME_REQ_DLVR_DT, -2) AS OVRS_ID_TIME_REQ_DLVR_DT,
             NVL (OVRS_ID_TIME_LAST_REC_DT, -2) AS OVRS_ID_TIME_LAST_REC_DT,
             NVL (OVRS_ID_TIME_PRVS_REC_DT, -2) AS OVRS_ID_TIME_PRVS_REC_DT,
             OVRS_ID_VEND_ID,
             OVRS_CD_VENDOR,
             OVRS_ID_STRL_STORAGE_LOC,
             OVRS_CD_STORAGE_LOC,
             OVRS_ID_MTRL_MATERIAL_ID,
             OVRS_CD_MATERIAL,
             OVRS_CD_PURCH_ORD,
             OVRS_CD_PURCH_ORD_LN,
             OVRS_CD_SEQ_ID,
             OVRS_CD_SCHED_LN_ID,
             OVRS_CD_RELEASE_NBR,
             OVRS_CD_MAT_DOC_ID,
             OVRS_QT_CUM_DLVR_NT_QTY,
             OVRS_QT_REQ_QTY,
             OVRS_QT_RCVD_QTY,
             OVRS_QT_OVERSHIPMENT,
             CASE
                 WHEN (OVRS_QT_OVERSHIPMENT > 0) THEN '1'
                 ELSE '0'
             END AS OVRS_FL_OVERSHIPMENT_MARKER,
             OVRS_CS_TOT_MANUF_COST,
             (OVRS_QT_OVERSHIPMENT * OVRS_CS_TOT_MANUF_COST) AS OVRS_AM_OVERSHIPMENT,
             OVRS_NR_DAYS_OF_OVERSHIPMENT,
             CASE
                 WHEN (OVRS_NR_DAYS_OF_OVERSHIPMENT > 0) THEN '1'
                 ELSE '0'
             END AS OVRS_FL_DAYS_OF_OVERSHIPMENT,
             OVRS_NR_DAYS_OF_PASTDUE,
             CASE
                 WHEN (OVRS_NR_DAYS_OF_PASTDUE > 0) THEN '1'
                 ELSE '0'
             END AS OVRS_FL_DAYS_OF_PASTDUE,
             OVRS_PC_OVERDLVR_LIMIT,
             CASE
                 WHEN ((OVRS_QT_OVERSHIPMENT / CASE
                                                   WHEN SCLN_QT_REQ_QTY != 0 THEN SCLN_QT_REQ_QTY
                                                   ELSE 0.01
                                               END) > OVRS_PC_OVERDLVR_LIMIT) THEN '1'
                 ELSE '0'
             END AS OVRS_FL_TOLERANCE_LIMIT,
             OVRS_CD_SUPPL_DLVR_NT,
             OVRS_FL_SUBCTR_MARK,
             OVRS_CD_PROD_ORD,
             OVRS_CD_OP_SUBSTR,
             CASE
                 WHEN (OVRS_NR_DAYS_OF_OVERSHIPMENT > 0) THEN (SLPR_QT_RCVD_QTY * OVRS_CS_TOT_MANUF_COST)
                 ELSE 0
             END AS OVRS_AM_OVERSHIPMENT_DAYS,
             OVRS_QT_PREV_CUM_REQ_QTY,
             OVRS_QT_PREV_CUM_REC_QTY,
             OVRS_QT_PREV_BALANC_QTY,
             NVL (P_ELT_ID_BATCH, N_ELT_ID_JOB_LOG) AS OVRS_ID_BATCH_ID,
             OVRS_CD_SOURCE_SYSTEM,
             SYSDATE AS OVRS_DT_INS_ROW,
             SYSDATE AS OVRS_DT_UPD_ROW,
             'ETL' AS OVRS_CD_OPERATOR_CODE
      FROM
        (SELECT OVRS_CD_PLANT_CD,
                OVRS_ID_OVRS,
                OVRS_ID_TIME_RECEPT_DT,
                OVRS_ID_TIME_REQ_DLVR_DT,
                OVRS_ID_TIME_LAST_REC_DT,
                OVRS_ID_TIME_PRVS_REC_DT,
                OVRS_ID_VEND_ID,
                OVRS_CD_VENDOR,
                OVRS_ID_STRL_STORAGE_LOC,
                OVRS_CD_STORAGE_LOC,
                OVRS_ID_MTRL_MATERIAL_ID,
                OVRS_CD_MATERIAL,
                OVRS_CD_PURCH_ORD,
                OVRS_CD_PURCH_ORD_LN,
                OVRS_CD_SCHED_LN_ID,
                OVRS_CD_SEQ_ID,
                TT_OSLN_OPEN_SCHED_LN.OSLN_CD_RELEASE_NUMBER AS OVRS_CD_RELEASE_NBR,
                OVRS_CD_MAT_DOC_ID,
                OVRS_QT_CUM_DLVR_NT_QTY,
                OVRS_QT_REQ_QTY,
                OVRS_QT_RCVD_QTY,
                SLPR_QT_RCVD_QTY,
                MASP_PC_OVERDLVR_LIMIT,
                SCLN_QT_REQ_QTY,
                CASE
                    WHEN (OVRS_QT_CUM_DLVR_NT_QTY > OVRS_QT_REQ_QTY) THEN LEAST (OVRS_QT_CUM_DLVR_NT_QTY - OVRS_QT_REQ_QTY, OVRS_QT_RCVD_QTY)
                    ELSE 0
                END AS OVRS_QT_OVERSHIPMENT,
                MACH_CS_TOT_MANUF_COST AS OVRS_CS_TOT_MANUF_COST,
                CASE
                    WHEN (SLPR_DT_RECEPT_DT < SCLN_DT_REQ_DLVR_DT) THEN GREATEST (((SCLN_DT_REQ_DLVR_DT - SLPR_DT_RECEPT_DT) - WD1) , 0)
                    ELSE 0
                END AS OVRS_NR_DAYS_OF_OVERSHIPMENT,
                CASE
                    WHEN (SLPR_DT_RECEPT_DT > SCLN_DT_REQ_DLVR_DT) THEN GREATEST (((SLPR_DT_RECEPT_DT - SCLN_DT_REQ_DLVR_DT) - WD1) , 0)
                    ELSE 0
                END AS OVRS_NR_DAYS_OF_PASTDUE,
                TM_MASP_MAT_SUPP_REL.MASP_PC_OVERDLVR_LIMIT AS OVRS_PC_OVERDLVR_LIMIT,
                OVRS_CD_SUPPL_DLVR_NT,
                CASE
                    WHEN (POLN_CD_ITM_CAT = '3') THEN '1'
                    ELSE '0'
                END AS OVRS_FL_SUBCTR_MARK,
                OVRS_CD_PROD_ORD,
                OVRS_CD_OP_SUBSTR,
                OVRS_QT_PREV_CUM_REQ_QTY,
                OVRS_QT_PREV_CUM_REC_QTY,
                (OVRS_QT_PREV_CUM_REQ_QTY - OVRS_QT_PREV_CUM_REC_QTY) AS OVRS_QT_PREV_BALANC_QTY,
                OVRS_CD_SOURCE_SYSTEM
         FROM
           (SELECT *
            FROM DDWH02_DM_MA.TW_OVRS_SLPR_OVERSHIPMENTS
            WHERE OVRS_CD_PLANT_CD = P_ELT_CD_PLANT ) OVRS,

           (SELECT *
            FROM DDWH01_DW_MA.TH_MACH_MAT_COST_HISTORY
            WHERE MACH_CD_PLANT_CD = P_ELT_CD_PLANT ) TH_MACH_MAT_COST_HISTORY,

           (SELECT *
            FROM DDWH01_DW_MA.TM_MASP_MAT_SUPP_REL
            WHERE MASP_CD_PLANT_CD = P_ELT_CD_PLANT
              AND MASP_FL_LOGICAL_DELETION = '0' ) TM_MASP_MAT_SUPP_REL,

           (SELECT MIN (OSLN_CD_RELEASE_NUMBER) AS OSLN_CD_RELEASE_NUMBER,
                       OSLN_CD_PURCH_ORD,
                       OSLN_CD_PART_NBR
            FROM DDWH01_DW_MA.TT_OSLN_OPEN_SCHED_LN
            WHERE OSLN_CD_PLANT_CD = P_ELT_CD_PLANT
            GROUP BY OSLN_CD_PURCH_ORD,
                     OSLN_CD_PART_NBR) TT_OSLN_OPEN_SCHED_LN
         WHERE OVRS.OVRS_CD_MATERIAL = TH_MACH_MAT_COST_HISTORY.MACH_CD_PART_NBR (+)
           AND SCLN_DT_REQ_DLVR_DT >= MACH_DT_STR_VALID_DT (+)
           AND SCLN_DT_REQ_DLVR_DT < MACH_DT_END_VALID_DT (+)
           AND OVRS.OVRS_CD_MATERIAL =TM_MASP_MAT_SUPP_REL.MASP_CD_PART_NBR (+)
           AND OVRS.OVRS_CD_VENDOR = TM_MASP_MAT_SUPP_REL.MASP_CD_SUPPL_CD (+)
           AND OVRS.PORD_CD_PURCH_ORG_CD = TM_MASP_MAT_SUPP_REL.MASP_CD_PURCH_ORG_CD (+)
           AND OVRS.POLN_CD_ITM_CAT = TM_MASP_MAT_SUPP_REL.MASP_CD_INFO_REC_CAT (+)
           AND OVRS.OVRS_CD_MATERIAL = TT_OSLN_OPEN_SCHED_LN.OSLN_CD_PART_NBR (+)
           AND OVRS.OVRS_CD_PURCH_ORD = TT_OSLN_OPEN_SCHED_LN.OSLN_CD_PURCH_ORD (+) ))) QRY ON (TRG.OVRS_CD_PLANT_CD = QRY.OVRS_CD_PLANT_CD
                                                                                                AND TRG.OVRS_ID_OVRS = QRY.OVRS_ID_OVRS) WHEN MATCHED THEN
UPDATE
SET TRG.OVRS_ID_TIME_RECEPT_DT = QRY.OVRS_ID_TIME_RECEPT_DT,
    TRG.OVRS_ID_TIME_REQ_DLVR_DT = QRY.OVRS_ID_TIME_REQ_DLVR_DT,
    TRG.OVRS_ID_TIME_LAST_REC_DT = QRY.OVRS_ID_TIME_LAST_REC_DT,
    TRG.OVRS_ID_TIME_PRVS_REC_DT = QRY.OVRS_ID_TIME_PRVS_REC_DT,
    TRG.OVRS_ID_VEND_ID = QRY.OVRS_ID_VEND_ID,
    TRG.OVRS_CD_VENDOR = QRY.OVRS_CD_VENDOR,
    TRG.OVRS_ID_STRL_STORAGE_LOC = QRY.OVRS_ID_STRL_STORAGE_LOC,
    TRG.OVRS_CD_STORAGE_LOC = QRY.OVRS_CD_STORAGE_LOC,
    TRG.OVRS_ID_MTRL_MATERIAL_ID = QRY.OVRS_ID_MTRL_MATERIAL_ID,
    TRG.OVRS_CD_MATERIAL = QRY.OVRS_CD_MATERIAL,
    TRG.OVRS_CD_PURCH_ORD = QRY.OVRS_CD_PURCH_ORD,
    TRG.OVRS_CD_PURCH_ORD_LN = QRY.OVRS_CD_PURCH_ORD_LN,
    TRG.OVRS_CD_SEQ_ID = QRY.OVRS_CD_SEQ_ID,
    TRG.OVRS_CD_SCHED_LN_ID = QRY.OVRS_CD_SCHED_LN_ID,
    TRG.OVRS_CD_RELEASE_NBR = QRY.OVRS_CD_RELEASE_NBR,
    TRG.OVRS_CD_MAT_DOC_ID = QRY.OVRS_CD_MAT_DOC_ID,
    TRG.OVRS_QT_CUM_DLVR_NT_QTY = QRY.OVRS_QT_CUM_DLVR_NT_QTY,
    TRG.OVRS_QT_REQ_QTY = QRY.OVRS_QT_REQ_QTY,
    TRG.OVRS_QT_RCVD_QTY = QRY.OVRS_QT_RCVD_QTY,
    TRG.OVRS_QT_OVERSHIPMENT = QRY.OVRS_QT_OVERSHIPMENT,
    TRG.OVRS_FL_OVERSHIPMENT_MARKER = QRY.OVRS_FL_OVERSHIPMENT_MARKER,
    TRG.OVRS_CS_TOT_MANUF_COST = QRY.OVRS_CS_TOT_MANUF_COST,
    TRG.OVRS_AM_OVERSHIPMENT = QRY.OVRS_AM_OVERSHIPMENT,
    TRG.OVRS_NR_DAYS_OF_OVERSHIPMENT = QRY.OVRS_NR_DAYS_OF_OVERSHIPMENT,
    TRG.OVRS_FL_DAYS_OF_OVERSHIPMENT = QRY.OVRS_FL_DAYS_OF_OVERSHIPMENT,
    TRG.OVRS_NR_DAYS_OF_PASTDUE = QRY.OVRS_NR_DAYS_OF_PASTDUE,
    TRG.OVRS_FL_DAYS_OF_PASTDUE = QRY.OVRS_FL_DAYS_OF_PASTDUE,
    TRG.OVRS_PC_OVERDLVR_LIMIT = QRY.OVRS_PC_OVERDLVR_LIMIT,
    TRG.OVRS_FL_TOLERANCE_LIMIT = QRY.OVRS_FL_TOLERANCE_LIMIT,
    TRG.OVRS_CD_SUPPL_DLVR_NT = QRY.OVRS_CD_SUPPL_DLVR_NT,
    TRG.OVRS_FL_SUBCTR_MARK = QRY.OVRS_FL_SUBCTR_MARK,
    TRG.OVRS_CD_PROD_ORD = QRY.OVRS_CD_PROD_ORD,
    TRG.OVRS_CD_OP_SUBSTR = QRY.OVRS_CD_OP_SUBSTR,
    TRG.OVRS_AM_OVERSHIPMENT_DAYS = QRY.OVRS_AM_OVERSHIPMENT_DAYS,
    TRG.OVRS_QT_PREV_CUM_REQ_QTY = QRY.OVRS_QT_PREV_CUM_REQ_QTY,
    TRG.OVRS_QT_PREV_CUM_REC_QTY = QRY.OVRS_QT_PREV_CUM_REC_QTY,
    TRG.OVRS_QT_PREV_BALANC_QTY = QRY.OVRS_QT_PREV_BALANC_QTY,
    TRG.OVRS_ID_BATCH_ID = QRY.OVRS_ID_BATCH_ID,
    TRG.OVRS_CD_SOURCE_SYSTEM = QRY.OVRS_CD_SOURCE_SYSTEM,
    TRG.OVRS_DT_INS_ROW = QRY.OVRS_DT_INS_ROW,
    TRG.OVRS_DT_UPD_ROW = QRY.OVRS_DT_UPD_ROW,
    TRG.OVRS_CD_OPERATOR_CODE = QRY.OVRS_CD_OPERATOR_CODE WHEN NOT MATCHED THEN
INSERT (OVRS_CD_PLANT_CD,
        OVRS_ID_OVRS,
        OVRS_ID_TIME_RECEPT_DT,
        OVRS_ID_TIME_REQ_DLVR_DT,
        OVRS_ID_TIME_LAST_REC_DT,
        OVRS_ID_TIME_PRVS_REC_DT,
        OVRS_ID_VEND_ID,
        OVRS_CD_VENDOR,
        OVRS_ID_STRL_STORAGE_LOC,
        OVRS_CD_STORAGE_LOC,
        OVRS_ID_MTRL_MATERIAL_ID,
        OVRS_CD_MATERIAL,
        OVRS_CD_PURCH_ORD,
        OVRS_CD_PURCH_ORD_LN,
        OVRS_CD_SEQ_ID,
        OVRS_CD_SCHED_LN_ID,
        OVRS_CD_RELEASE_NBR,
        OVRS_CD_MAT_DOC_ID,
        OVRS_QT_CUM_DLVR_NT_QTY,
        OVRS_QT_REQ_QTY,
        OVRS_QT_RCVD_QTY,
        OVRS_QT_OVERSHIPMENT,
        OVRS_FL_OVERSHIPMENT_MARKER,
        OVRS_CS_TOT_MANUF_COST,
        OVRS_AM_OVERSHIPMENT,
        OVRS_NR_DAYS_OF_OVERSHIPMENT,
        OVRS_FL_DAYS_OF_OVERSHIPMENT,
        OVRS_NR_DAYS_OF_PASTDUE,
        OVRS_FL_DAYS_OF_PASTDUE,
        OVRS_PC_OVERDLVR_LIMIT,
        OVRS_FL_TOLERANCE_LIMIT,
        OVRS_CD_SUPPL_DLVR_NT,
        OVRS_FL_SUBCTR_MARK,
        OVRS_CD_PROD_ORD,
        OVRS_CD_OP_SUBSTR,
        OVRS_AM_OVERSHIPMENT_DAYS,
        OVRS_QT_PREV_CUM_REQ_QTY,
        OVRS_QT_PREV_CUM_REC_QTY,
        OVRS_QT_PREV_BALANC_QTY,
        OVRS_ID_BATCH_ID,
        OVRS_CD_SOURCE_SYSTEM,
        OVRS_DT_INS_ROW,
        OVRS_DT_UPD_ROW,
        OVRS_CD_OPERATOR_CODE)
VALUES (QRY.OVRS_CD_PLANT_CD, QRY.OVRS_ID_OVRS, QRY.OVRS_ID_TIME_RECEPT_DT, QRY.OVRS_ID_TIME_REQ_DLVR_DT, QRY.OVRS_ID_TIME_LAST_REC_DT, QRY.OVRS_ID_TIME_PRVS_REC_DT, QRY.OVRS_ID_VEND_ID, QRY.OVRS_CD_VENDOR, QRY.OVRS_ID_STRL_STORAGE_LOC, QRY.OVRS_CD_STORAGE_LOC, QRY.OVRS_ID_MTRL_MATERIAL_ID, QRY.OVRS_CD_MATERIAL, QRY.OVRS_CD_PURCH_ORD, QRY.OVRS_CD_PURCH_ORD_LN, QRY.OVRS_CD_SEQ_ID, QRY.OVRS_CD_SCHED_LN_ID, QRY.OVRS_CD_RELEASE_NBR, QRY.OVRS_CD_MAT_DOC_ID, QRY.OVRS_QT_CUM_DLVR_NT_QTY, QRY.OVRS_QT_REQ_QTY, QRY.OVRS_QT_RCVD_QTY, QRY.OVRS_QT_OVERSHIPMENT, QRY.OVRS_FL_OVERSHIPMENT_MARKER, QRY.OVRS_CS_TOT_MANUF_COST, QRY.OVRS_AM_OVERSHIPMENT, QRY.OVRS_NR_DAYS_OF_OVERSHIPMENT, QRY.OVRS_FL_DAYS_OF_OVERSHIPMENT, QRY.OVRS_NR_DAYS_OF_PASTDUE, QRY.OVRS_FL_DAYS_OF_PASTDUE, QRY.OVRS_PC_OVERDLVR_LIMIT, QRY.OVRS_FL_TOLERANCE_LIMIT, QRY.OVRS_CD_SUPPL_DLVR_NT, QRY.OVRS_FL_SUBCTR_MARK, QRY.OVRS_CD_PROD_ORD, QRY.OVRS_CD_OP_SUBSTR, QRY.OVRS_AM_OVERSHIPMENT_DAYS, QRY.OVRS_QT_PREV_CUM_REQ_QTY, QRY.OVRS_QT_PREV_CUM_REC_QTY, QRY.OVRS_QT_PREV_BALANC_QTY, QRY.OVRS_ID_BATCH_ID, QRY.OVRS_CD_SOURCE_SYSTEM, QRY.OVRS_DT_INS_ROW, QRY.OVRS_DT_UPD_ROW, QRY.OVRS_CD_OPERATOR_CODE)