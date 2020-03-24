      ******************************************************************
      * Author:
      * Date:
      * Purpose:
      * Tectonics: cobc
      ******************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TA-RANKING.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT OPTIONAL INPUT-INSTRUCTOR ASSIGN TO 'instructors.txt'
             ORGANIZATION IS LINE SEQUENTIAL
             FILE STATUS IS INPUT-INSTRUCTOR-STATUS.
           SELECT OPTIONAL INPUT-CANDIDATE ASSIGN TO 'candidates.txt'
             ORGANIZATION IS LINE SEQUENTIAL
             FILE STATUS IS INPUT-CANDIDATE-STATUS.
           SELECT OUTPUT-FILE ASSIGN TO 'output1.txt'
             ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD INPUT-INSTRUCTOR.
       01 COURSE-DATA.
           03 COURSE PIC X(5).
           03 REQUIRED-TABLE.
               05 REQUIRED-SKILL PIC X(15) OCCURS 3 TIMES.
           03 OPTIONAL-TABLE.
               05 OPTIONAL-SKILL PIC X(15) OCCURS 5 TIMES.
       FD INPUT-CANDIDATE.
       01 TA-DATA-TABLE.
           03 SID PIC 9(11).
           03 SKILLS-TABLE.
               05 SKILL PIC X(15) OCCURS 8 TIMES.
           03 PREFER-TABLE.
               05 PREFER PIC 9(5) OCCURS 3 TIMES.
       FD OUTPUT-FILE.
       01 RANK-RESULT.
           03 RES-COURSE PIC X(5).
           03 RANK1 PIC X(11).
           03 RANK2 PIC X(11).
           03 RANK3 PIC X(11).
           03 EOL PIC X.

       WORKING-STORAGE SECTION.
       77 INPUT-INSTRUCTOR-STATUS PIC 9(2).
       77 INPUT-CANDIDATE-STATUS  PIC 9(2).

       01 WS-COURSE-DATA.
           03 WS-COURSE PIC X(5) VALUES SPACE.
           03 WS-REQUIRED-TABLE.
             05 WS-REQUIRED-SKILL PIC X(15) OCCURS 3 TIMES VALUES SPACE.
           03 WS-OPTIONAL-TABLE.
             05 WS-OPTIONAL-SKILL PIC X(15) OCCURS 5 TIMES VALUES SPACE.
       01 WS-TA-DATA.
           03 WS-SID PIC 9(11) VALUES ZERO.
           03 WS-SKILLS-TABLE.
               05 WS-SKILL PIC X(15) OCCURS 8 TIMES VALUES SPACE.
           03 WS-PREFER-TABLE.
               05 WS-PREFER PIC X(5) OCCURS 3 TIMES VALUES ZERO.

       01 WS-TA-SCORE-TABLE.
           03 WS-TA-SCORE OCCURS 3 TIMES.
               05 WS-SCORE PIC 9V9 VALUES ZERO.
               05 WS-RES-SID PIC 9(10) VALUES ZERO.
       01 WS-RANK-RESULT VALUES SPACE.
           03 WS-RES-COURSE PIC X(5).
           03 WS-RANK1 PIC X(11).
           03 WS-RANK2 PIC X(11).
           03 WS-RANK3 PIC X(11).
           03 WS-EOL PIC X.

       01 WS-EOF-INSTRUCTOR PIC A(1) VALUES SPACE.
       01 WS-EOF-CANDIDATE PIC A(1) VALUES SPACE.

       01 I PIC 9(3) VALUE ZERO.
       01 J PIC 9(3) VALUE ZERO.
       01 FLAG PIC A(1) VALUE 'N'.
       01 SATISFIED PIC A(1) VALUE SPACE.

       01 CUR-SID PIC 9(10) VALUE ZERO.
       01 CUR-SCORE PIC 9V9 VALUE ZERO.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           OPEN INPUT INPUT-INSTRUCTOR.

           OUTER-LOOP.
           READ INPUT-INSTRUCTOR INTO WS-COURSE-DATA
               AT END MOVE 'Y' TO WS-EOF-INSTRUCTOR
      *>       NOT AT END DISPLAY WS-COURSE-DATA
           END-READ.

           IF WS-EOF-INSTRUCTOR NOT = 'Y'
               OPEN INPUT INPUT-CANDIDATE
               MOVE 'N' TO WS-EOF-CANDIDATE
               PERFORM LOOP
               CLOSE INPUT-CANDIDATE
               GO TO OUTER-LOOP
           END-IF.

           CLOSE INPUT-INSTRUCTOR.

       STOP RUN.

       LOOP.
           READ INPUT-CANDIDATE INTO WS-TA-DATA
               AT END MOVE 'Y' TO WS-EOF-CANDIDATE
      *    >      NOT AT END DISPLAY WS-TA-DATA
           END-READ.

               IF WS-EOF-CANDIDATE NOT = 'Y'
               PERFORM CALCULATE
               DISPLAY WS-COURSE WS-SID CUR-SCORE
               GO TO LOOP
           END-IF.

       CALCULATE.
           MOVE 0.0 TO CUR-SCORE.
           MOVE 'Y' TO SATISFIED.
           PERFORM CHECK-REQUIRED.
           IF SATISFIED='Y'
               ADD 1.0 TO CUR-SCORE
               PERFORM CHECK-OPTIONAL
               PERFORM CHECK-PREFER
           END-IF.

       CHECK-REQUIRED.
           MOVE 1 TO I.
           PERFORM REQUIRED-OUTER-LOOP.
           REQUIRED-OUTER-LOOP.
           IF I<=3
               MOVE 'N' TO FLAG
               MOVE 1 TO J
               PERFORM REQUIRED-INNER-LOOP
               IF FLAG NOT = 'Y'
                   MOVE 'N' TO SATISFIED
               END-IF
           ADD 1 TO I
           GO TO REQUIRED-OUTER-LOOP
           END-IF.

       REQUIRED-INNER-LOOP.
           IF J<=8
               IF WS-REQUIRED-SKILL(I)=WS-SKILL(J)
      *>              DISPLAY WS-COURSE WS-SID WS-SKILL(J)
                   MOVE 'Y' TO FLAG
               END-IF
               ADD 1 TO J
               GO TO REQUIRED-INNER-LOOP
           END-IF.

       CHECK-OPTIONAL.
           MOVE 1 TO I.
           PERFORM OPTIONAL-OUTER-LOOP.
           OPTIONAL-OUTER-LOOP.
           IF I<=5
               MOVE 'N' TO FLAG
               MOVE 1 TO J
               PERFORM OPTIONAL-INNER-LOOP
               IF FLAG = 'Y'
                   ADD 1 TO CUR-SCORE
               END-IF
           ADD 1 TO I
           GO TO OPTIONAL-OUTER-LOOP
           END-IF.

       OPTIONAL-INNER-LOOP.
           IF J<=8
               IF WS-OPTIONAL-SKILL(I)=WS-SKILL(J)
                   MOVE 'Y' TO FLAG
               END-IF
               ADD 1 TO J
               GO TO OPTIONAL-INNER-LOOP
           END-IF.

       CHECK-PREFER.
           MOVE 1 TO I.
           MOVE 'N' TO FLAG.
           PERFORM PREFER-LOOP.
           PREFER-LOOP.
           IF I<=3
               IF WS-COURSE=WS-PREFER(I)
                   IF FLAG='N'
                       COMPUTE CUR-SCORE=CUR-SCORE + (4 - I) * 0.5
                       MOVE 'Y' TO FLAG
                   END-IF
               END-IF
           ADD 1 TO I
           GO TO PREFER-LOOP
           END-IF.
