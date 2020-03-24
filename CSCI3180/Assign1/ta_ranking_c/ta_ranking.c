#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct result{
    unsigned int sid;
    float score;
};

void storeInfo(char *line, char *course, int len, char required[][16], char optional[][16], char prefer[][5]){
    int i;
    // initialize buffers
    memset(course, 0, len+1);
    memset(required, 0, 3 * 16);
    memset(optional, 0, 5 * 16);
    
    // store course code or sid
    memcpy(course, line, len);

    // store required skills
    for (i = 0; i < 3; i++){
        // each time, required moves forward 16 and line moves forward 15
        memcpy(&required[i][0], &line[len+1 + i*15], 15);
    }

    for (i = 0; i < 3; i++){
        //printf("%s\n", &required[i][0]);
    }

    // store optional skills
    for (i = 0; i < 5; i++){
        memcpy(optional[i], (line + len+1 + 3*15) + i * 15, 15);
    }

    for (i = 0; i < 5; i++){
        //printf("%s\n", optional[i]);
    }

    // store preferences
    if (prefer != NULL){
        memset(prefer, 0, 3 * 5);
        for (i = 0; i < 3; i++){
            memcpy(prefer[i], &line[len + 1 + 8*15 + i*5], 4);
        }
    }
}

float calculate(char *course, char required[][16], char optional[][16], char skills[][16], char prefer[][5]){
    int i, j, flag = 0;
    float score = 0;
    // check required skills
    for (i = 0; i < 3; i++){
        flag = 0;
        for (j = 0; j < 8; j++){
            if (memcmp(required[i], skills[j], 15) == 0){
                flag = 1;
                break;
            }
        }
        if (flag == 0){
            // no required skill required[i]
            return 0;
        }
    }
    score += 1;

    // add score for optional skills
    for (i = 0; i < 5; i++){
        flag = 0;
        for (j = 0; j < 8; j++){
            if (memcmp(optional[i], skills[j], 15) == 0){
                flag = 1;
                break;
            }
        }
        if (flag == 1){
            // find a satisfied optional skill
            score += 1;
        }
    }    

    // add score for preferences
    for (i = 0; i < 3; i++){
        if (memcmp(course, prefer[i], 4) == 0){
            score += (3 - i) * 0.5;
            break;
        }
    }

    return score;
}

void addRes(struct result *result, unsigned int sid, float score){
    int i, j;
    // keep the pointer to last struct

    printf("new %d %f\n", sid, score);

    // construct a new result structure for course[i] and candidate[j]
    struct result new;
    new.sid = sid;
    new.score = score;
    
    // insert sort
    for (i = 2; i >= 0; i--){
        printf("i: %d\n", i);
        if (new.score < result[i].score || (new.score == result[i].score && new.sid > result[i].sid)){
            break;
        }
    }

    // the i-th has higher priority than new
    for (j = 2-1; j >= i+1; j--){
        result[j + 1] = result[j];
    }
    if (i + 1 < 3){
        result[i+1] = new;
    }
}

void output(char* course, FILE *fd, struct result *res){
    char buf[11];

    course[4] = ' ';
    fwrite(course, sizeof(char), 5, fd);

    for (int i = 0; i < 3; i++){
        memset(buf, '0', sizeof(buf));
        if (res[i].sid != 0){
            sprintf(buf, "%d", res[i].sid);
        }
        // assign ' ' to the 11th char in buf 
        buf[10] = ' ';
        fwrite(buf, sizeof(buf), 1, fd);
    }

    fputc('\n', fd);
}

int main(){
    int empty = 1;
    char buf[256];

    char course[5];
    char required[3][16];
    char optional[5][16];

    unsigned int sid;
    char strSid[11];
    char skills[8][16];
    char prefer[3][5];

    struct result result[3];

    memset(result, 0, sizeof(struct result) * 3);

    FILE *fdInstructor = fopen("instructors.txt", "rb");
    FILE *fdCandidate = fopen("candidates.txt", "rb");

    // if instructors.txt or candidates.txt doesn't exit
    if (fdInstructor == NULL || fdCandidate == NULL){
        printf("non-existing file!");
        return (0);
    }

    FILE *fdOutput = fopen("output1.txt", "wb");

    // if instructors.txt is empty
    // if candidates.txt is empty

    while(1){
        memset(buf, 0, sizeof(buf));
        if (fgets(buf, sizeof(buf), fdInstructor) == NULL){
            break;
        }
        else{
            empty = 0;
            /*** read from instructors.txt ***/

            // required[i][14] == optional[i][14] == ' '
            // required[i][15] == optional[i][15] == '\0'
            // len(course) = 4
            storeInfo(buf, course, 4, required, optional, NULL);
            printf("outer course:%s\n", course);

            /*** read from candidates.txt ***/
            float score;
            fseek(fdCandidate, 0, SEEK_SET);
            memset(result, 0, sizeof(struct result) * 3);
            while(1){
                memset(buf, 0, sizeof(buf));

                if (fgets(buf, sizeof(buf), fdCandidate) == NULL){
                    break;
                }
                else{
                    // len(string sid) = 10
                    storeInfo(buf, strSid, 10, skills, &skills[3], prefer);
                    sid = atoi(strSid);
                    score = calculate(course, required, optional, skills, prefer);
                    // printf("%f\n", score);
                    printf("course: %s, sid: %d, score: %f\n", course, sid, score);
                    // add score into result
                    addRes(result, sid, score);
                    for (int i = 0; i < 3; i++){
                        printf("%d %f\n", result[i].sid, result[i].score);
                    }
                }
            }
        }
        printf("\nend a loop, courses: %s\n", course);
        for (int i = 0; i < 3; i++){
            printf("%d %f\n", result[i].sid, result[i].score);
        }
        printf("\n");

        output(course, fdOutput, result);
    }

    // instructoris empty -> output is empty
    fclose(fdOutput);
    fclose(fdCandidate);
    fclose(fdInstructor);
}