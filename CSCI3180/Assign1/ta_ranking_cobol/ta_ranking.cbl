      ******************************************************************
      * CSCI3180 Principles of Programming Languages
      * --- Declaration ---
      * I declare that the assignment here submitted is original except for source
      * material explicitly acknowledged. I also acknowledge that I am aware of
      * University policy and regulations on honesty in academic work, and of the
      * disciplinary guidelines and procedures applicable to breaches of such policy
      * and regulations, as contained in the website
      * http://www.cuhk.edu.hk/policy/academichonesty
      * Assignment 1
      * Name : GAO Ming Yuan
      * Student ID : 1155107738
      * Email Addr : 1155107738@link.cuhk.edu.hk
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
           SELECT OUTPUT-FILE ASSIGN TO 'output.txt'
             ORGANIZATION IS BINARY SEQUENTIAL.

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
           03 SID PIC 9(10).
           03 TRASH-SPACE PIC A(1).
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
           03 MY-EOL PIC X.

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
           03 WS-SID PIC 9(10) VALUES ZERO.
           03 WS-TRASH-SPACE PIC A(1).
           03 WS-SKILLS-TABLE.
               05 WS-SKILL PIC X(15) OCCURS 8 TIMES VALUES SPACE.
           03 WS-PREFER-TABLE.
               05 WS-PREFER PIC X(5) OCCURS 3 TIMES VALUES ZERO.

       01 WS-TOP-TA-TABLE.
           03 WS-TOP-TA OCCURS 3 TIMES.
               05 WS-RES-SCORE PIC 9V9 VALUES ZERO.
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
           PERFORM ERROR-HANDLING.

           OPEN INPUT INPUT-INSTRUCTOR.
           OPEN OUTPUT OUTPUT-FILE.

           OUTER-LOOP.
           READ INPUT-INSTRUCTOR INTO WS-COURSE-DATA
               AT END MOVE 'Y' TO WS-EOF-INSTRUCTOR
      *>       NOT AT END DISPLAY WS-COURSE-DATA
           END-READ.

           IF WS-EOF-INSTRUCTOR NOT = 'Y'
               MOVE ZERO TO WS-TOP-TA-TABLE
               OPEN INPUT INPUT-CANDIDATE
               MOVE 'N' TO WS-EOF-CANDIDATE
               PERFORM LOOP
               CLOSE INPUT-CANDIDATE
               PERFORM WRITE-TO-FILE
               GO TO OUTER-LOOP
           END-IF.

           CLOSE INPUT-INSTRUCTOR.
           CLOSE OUTPUT-FILE.
       STOP RUN.

       LOOP.
           READ INPUT-CANDIDATE INTO WS-TA-DATA
               AT END MOVE 'Y' TO WS-EOF-CANDIDATE
      *    >      NOT AT END DISPLAY WS-TA-DATA
           END-READ.

           IF WS-EOF-CANDIDATE NOT = 'Y'
               PERFORM CALCULATE
               PERFORM ADD-RES
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

       ADD-RES.
           PERFORM INSERT-SORT.
           PERFORM MOVE-CUR.


       INSERT-SORT.
           MOVE 3 TO I.
           PERFORM FIND-POS-LOOP.

      *>  FIND THE POS WHERE CUR-TA SHOULD BE INSERTED IN
       FIND-POS-LOOP.
           IF I>=1
               IF CUR-SCORE > WS-RES-SCORE(I)
                   SUBTRACT 1 FROM I
                   GO TO FIND-POS-LOOP
               END-IF.
               IF CUR-SCORE = WS-RES-SCORE(I)
                   IF WS-SID < WS-RES-SID(I)
                       SUBTRACT 1 FROM I
                       GO TO FIND-POS-LOOP
               END-IF.

      *>  the i-th has higher priority than new
       MOVE-CUR.
           MOVE 2 TO J.
           PERFORM MOVE-ARRAY-LOOP.
           IF I + 1 <= 3
      *>       SET A NEW WS-TOP-TA STRUCT WITH CUR-SID AND CUR-SCORE
               MOVE WS-SID TO WS-RES-SID(I + 1)
               MOVE CUR-SCORE TO WS-RES-SCORE(I + 1)
           END-IF.

       MOVE-ARRAY-LOOP.
           IF J >= I + 1
               MOVE WS-TOP-TA(J) TO WS-TOP-TA(J + 1)
               SUBTRACT 1 FROM J
               GO TO MOVE-ARRAY-LOOP
           END-IF.

       WRITE-TO-FILE.
           MOVE WS-COURSE TO RES-COURSE.
           MOVE WS-RES-SID(1) TO RANK1.
           MOVE WS-RES-SID(2) TO RANK2.
           MOVE WS-RES-SID(3) TO RANK3.
           MOVE x'0a' TO MY-EOL.
           WRITE RANK-RESULT
           END-WRITE.

       ERROR-HANDLING.
           OPEN INPUT INPUT-INSTRUCTOR.
           IF INPUT-INSTRUCTOR-STATUS = 05
               DISPLAY "non-existing file!"
               CLOSE INPUT-INSTRUCTOR
               STOP RUN
           END-IF.
           CLOSE INPUT-INSTRUCTOR.

           OPEN INPUT INPUT-CANDIDATE.
           IF INPUT-CANDIDATE-STATUS = 05
               DISPLAY "non-existing file!"
               CLOSE INPUT-CANDIDATE
               STOP RUN
           END-IF.

           CLOSE INPUT-INSTRUCTOR.
           CLOSE INPUT-CANDIDATE.
