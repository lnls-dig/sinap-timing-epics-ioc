# 1 "../sncSeqRAMProgram.st"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "../sncSeqRAMProgram.st"
# 1 "./../sncSeqRAM.stt" 1
program sncSeqRAM

%%
foreign ssId;

%%
%%
%%

int eventNum;
int expandedEventNum;
char * device;
char * evCodeName = "EVCODE";
char * evTimeName = "EVTIME";
char * evModeName = "EVDLYMODE";
char * evCtrlName = "EVTRANSM";
char str[40];
int i;
int numberOfWrites;

%%
%%
%%

int StateMachineStatus;
assign StateMachineStatus to "{device}:STATEMACHINE";

%%
%%
%%

int network;
assign network to "{device}:network";
monitor network;

int tbl[2000];
assign tbl to "{device}:ITBL";

int tbl_length;
assign tbl_length to "{device}:ITBL.NORD";

int seqs;
assign seqs to "{device}:seqstat";
monitor seqs;

int seqen_rbv;
assign seqen_rbv to "{device}:seqenRBV";
monitor seqen_rbv;

int seqen;
assign seqen to "{device}:seqen";
int seqsw;
assign seqsw to "{device}:seqram_switch.PROC";
int seqaddr;
assign seqaddr to "{device}:seqaddr";
int seqcode;
assign seqcode to "{device}:seqcode";
int seqtime;
assign seqtime to "{device}:seqtime";

int seqcount;
assign seqcount to "{device}:seqcountRBV";
monitor seqcount;

int event_codes[20];
assign event_codes to {};

int event_timestamps[20];
assign event_timestamps to {};

int event_modes[20];
assign event_modes to {};

int event_ctrl[20];
assign event_ctrl to {};

%%
%%
%%

int stop_pv;
assign stop_pv to "{device}:STOPSEQ";
monitor stop_pv;

int stop_tg;
assign stop_tg to "{device}:STOP_TG.PROC";
monitor stop_tg;
evflag stopFlag;
sync stop_tg stopFlag;

int stopinj_pv;
assign stopinj_pv to "{device}:STOPINJSEQ";
monitor stopinj_pv;

int stopinj_tg;
assign stopinj_tg to "{device}:STOPINJ_TG.PROC";
monitor stopinj_tg;
evflag stopInjFlag;
sync stopinj_tg stopInjFlag;

int run_pv;
assign run_pv to "{device}:RUNSEQ";
monitor run_pv;

int run_tg;
assign run_tg to "{device}:RUN_TG.PROC";
monitor run_tg;
evflag runFlag;
sync run_tg runFlag;

int inj_pv;
assign inj_pv to "{device}:INJSEQ";
monitor inj_pv;

int inj_tg;
assign inj_tg to "{device}:INJ_TG.PROC";
monitor inj_tg;
evflag injFlag;
sync inj_tg injFlag;

int restart_pv;
assign restart_pv to "{device}:RESTSEQ";
monitor restart_pv;

int restart_tg;
assign restart_tg to "{device}:RESTART_TG.PROC";
monitor restart_tg;
evflag restFlag;
sync restart_tg restFlag;

int update_pv;
assign update_pv to "{device}:UPDATEEV";
monitor update_pv;

int update_tg;
assign update_tg to "{device}:UPDATE_TG.PROC";
monitor update_tg;
evflag updateFlag;
sync update_tg updateFlag;

%%
%%
%%

int train_enable;
assign train_enable to "{device}:PTEN";
monitor train_enable;

int train_pulse_cnt;
assign train_pulse_cnt to "{device}:PTCNT";
monitor train_pulse_cnt;

int train_pulse_size;
assign train_pulse_size to "{device}:PTSIZE";
monitor train_pulse_size;

int train_start_time;
assign train_start_time to "{device}:PTTIME";
monitor train_start_time;

int train_pulse_code;
assign train_pulse_code to "{device}:PTCODE";
monitor train_pulse_code;

%%
%%
%%

%%#include <stdlib.h>
%%#include <math.h>

%{



    typedef enum{
 FIX = 0,
 INCR = 1
    } evmode;


    typedef enum{
 ALWAYS = 0,
 INJECTION = 1
    } evctrl;


    typedef struct Event{
 int code;
 int timestamp;
 evmode mode;
 evctrl ctrl;
    } Event;




    Event * EventPointerArray[20];

    Event EventArray[20];

    const int sizeOfArrays = 20;

    Event ExpandedEventArray[2090];

    const int sizeOfExpArray = 2090;


    int str2int(char * str);
    int ch2int(char ch);
    void init_EventPointerArray(int size);
    int bubbleSort(Event * * evArray, int arraySize);
    void swap(Event* *a, Event* *b);
    void updateEventPointerArray(int evNumber, int * code_arr,
     int * time_arr, int * mode_arr, int * control_arr);
    int seqOneWrite(int evnum, SS_ID ssId, int *pseqaddr, int *pseqcode, int *pseqtime, int *pseqcount,
     VAR_ID seqaddr_id, VAR_ID seqcode_id, VAR_ID seqtime_id, VAR_ID seqcount_id);

    int seqTwoWrite(int evnum, int TBL[], int length, SS_ID ssId, int *pseqaddr, int *pseqcode, int *pseqtime, int *pseqcount,
      VAR_ID seqaddr_id, VAR_ID seqcode_id, VAR_ID seqtime_id, VAR_ID seqcount_id);

    int expandArray(int evnum, int trainEnable, int pulseCnt, int trainDuration, int trainStart, int trainCode);
    int trainStartCorrection(int trainEnable, int trainStart, int trainDuration, int pulseCnt, int evnum);
    int updateExpandedArray(int trainEnable, int trainStart, int trainDuration, int pulseCnt, int trainCode, int evnum);
}%

%%
%%
%%

ss seq {

    state init{
 entry
 {

    %{



      }%

   %%
    StateMachineStatus = 0;
    numberOfWrites = 0;
    expandedEventNum = 0;

   %%
    eventNum = str2int(macValueGet("ev_num"));
    device = macValueGet("device");

   %%
    for (i = 0; i < eventNum; i++) {
      sprintf (str, "%s:%s%d", device, evCodeName, i);
      pvAssign (event_codes[i], str);
      printf("%s\n", str);
    }
    for (i = 0; i < eventNum; i++) {
      sprintf (str, "%s:%s%d", device, evTimeName, i);
      pvAssign (event_timestamps[i], str);
    }
    for (i = 0; i < eventNum; i++) {
      sprintf (str, "%s:%s%d", device, evModeName, i);
      pvAssign (event_modes[i], str);
    }
    for (i = 0; i < eventNum; i++) {
      sprintf (str, "%s:%s%d", device, evCtrlName, i);
      pvAssign (event_ctrl[i], str);
    }

   %%
    init_EventPointerArray(eventNum);

   %%
    for(i = 0; i < eventNum; i++){

  pvGet(event_codes[i], SYNC);
  pvGet(event_timestamps[i], SYNC);
  pvGet(event_modes[i], SYNC);
  pvGet(event_ctrl[i], SYNC);
    }

   %%
    updateEventPointerArray(eventNum, event_codes, event_timestamps, event_modes, event_ctrl);

   %%
    expandedEventNum = updateExpandedArray(train_enable, train_start_time, train_pulse_size,
       train_pulse_cnt, train_pulse_code, eventNum);

    printf("Initialization Entry\n");
 }

 when(seqs == 0 && network == 1)
 {
  %{ }%

  printf("Moving to Stopped State\n");
 } state Stopped

 when(seqs == 1 && network == 1)
 {
  %{ }%

  printf("Moving to Running State\n");
 } state Running

 when(seqs == 2 && network == 1)
 {
  %{ }%

  printf("Moving to Injecting State\n");
 } state Injecting
    }

    state Stopped {
 entry{

    %{







      }%

    %%
    StateMachineStatus = 1;
    pvPut(StateMachineStatus, SYNC);

    %%
    efClear(runFlag);
    efClear(updateFlag);

    %%
    for(i = 0; i < eventNum; i++){

  pvGet(event_codes[i], SYNC);
  pvGet(event_timestamps[i], SYNC);
  pvGet(event_modes[i], SYNC);
  pvGet(event_ctrl[i], SYNC);
    }

    %%
    updateEventPointerArray(eventNum, event_codes, event_timestamps, event_modes, event_ctrl);

    %%
    expandedEventNum = updateExpandedArray(train_enable, train_start_time, train_pulse_size,
       train_pulse_cnt, train_pulse_code, eventNum);

    %%

    %%
    seqen = 0;
    pvPut(seqen, SYNC);

    %%
    numberOfWrites = 0;

    printf("Stopped Entry\n");
 }

 when(seqen_rbv == 0 && seqcount != 0){

  %{ }%

  seqsw = 1;
  pvPut(seqsw, SYNC);

 }state Stopped

 when(efTestAndClear(updateFlag) && update_tg){

  %{ }%

  %%
     StateMachineStatus = 5;
  pvPut(StateMachineStatus, SYNC);

  %%
     for(i = 0; i < eventNum; i++){

   pvGet(event_codes[i], SYNC);
   pvGet(event_timestamps[i], SYNC);
   pvGet(event_modes[i], SYNC);
   pvGet(event_ctrl[i], SYNC);
     }

  %%
     updateEventPointerArray(eventNum, event_codes, event_timestamps, event_modes, event_ctrl);

  %%
  expandedEventNum = updateExpandedArray(train_enable, train_start_time, train_pulse_size,
       train_pulse_cnt, train_pulse_code, eventNum);

  %%
     StateMachineStatus = 1;
  pvPut(StateMachineStatus, SYNC);

  printf("Update Finished\n");
 } state Stopped

 when(efTestAndClear(runFlag) && run_tg && (seqcount == 0)){

  %{ }%

  %%
     StateMachineStatus = 6;
  pvPut(StateMachineStatus, SYNC);

  numberOfWrites = seqOneWrite(expandedEventNum, ssId, &seqaddr, &seqcode, &seqtime, &seqcount,
     pvIndex(seqaddr), pvIndex(seqcode), pvIndex(seqtime), pvIndex(seqcount));

  printf("Run Triggered\n");
 } state CheckSeq1Write

 when(seqs == 1){

  %{ }%

  printf("Moving to Running State\n");
 } state Running
    }

    state CheckSeq1Write{

 entry{

     %{

       }%

     printf("CheckSeq1Write Entry\n");

     printf("Debugging EVG:seqen: numberOfWrites= %d, seqcount= %d, seqen_rbv= %d, seqs=%d\n", numberOfWrites, seqcount, seqen_rbv, seqs);
 }

 when(seqcount == numberOfWrites && seqen_rbv == 0){

  %{ }%

  %%
  seqen = 1;
  pvPut(seqen, SYNC);

  %%
  seqsw = 1;
  pvPut(seqsw, SYNC);

  printf("Write succeded: seqen=%d, seqs=%d\n", seqen, seqs);

 } state CheckSeq1Write

 when(seqs == 1){

  printf("Going from CheckSeq1Write to Running State\n");

  %{ }%

  printf("Moving to Running State\n");
 } state Running

 when(delay(5.0) && seqen_rbv == 0){

  %{ }%

  printf("CheckSeq1Write: Unseccessful Write to Seq1, going to Stopped State\n");

  %%

  printf("Error: Write to SeqRAM 1 Failed.\n");

 } state Stopped
    }

    state Running {

 entry{

     %{





       }%

    %%
    StateMachineStatus = 2;
    pvPut(StateMachineStatus, SYNC);

    %%
    efClear(stopFlag);
    efClear(injFlag);
    efClear(restFlag);

    %%
    numberOfWrites = 0;

    printf("Running Entry\n");
 }

 when(efTestAndClear(stopFlag) && stop_tg){

  %{ }%

  %%
  seqen = 0;
  pvPut(seqen, SYNC);

      printf("Stop Triggered\n");
 } state Running

 when(seqs == 0){

  %{ }%

      printf("Moving to Stopped State\n");
 } state Stopped

 when(efTestAndClear(injFlag) && inj_tg){

  %{



    }%

  %%
     StateMachineStatus = 7;
  pvPut(StateMachineStatus, SYNC);

  %%
  pvGet(tbl, SYNC);

  %%
  pvGet(tbl_length, SYNC);

  %%
  numberOfWrites = seqTwoWrite(expandedEventNum, tbl, tbl_length, ssId, &seqaddr, &seqcode, &seqtime, &seqcount,
      pvIndex(seqaddr), pvIndex(seqcode), pvIndex(seqtime), pvIndex(seqcount));

      printf("Injection Triggered\n");
 } state CheckSeq2Write

 when(seqs == 2){

  %{ }%

      printf("Moving to Injecting State\n");
 } state Injecting

 when(efTestAndClear(restFlag) && restart_tg){

  %{ }%

     printf("Moving to Restarting State\n");
 } state Restarting
    }

    state CheckSeq2Write{

 entry{

     %{

       }%

     printf("CheckSeq2Write Entry\n");
 }

 when(seqcount == numberOfWrites){

  %{ }%

  %%
  numberOfWrites = -1;

  %%
  seqsw = 1;
  pvPut(seqsw, SYNC);

 } state CheckSeq2Write

 when(seqs == 2){

  %{ }%

  printf("Moving to Injecting State\n");
 } state Injecting

 when(delay(5.0) && seqs != 2){

  %{ }%

  %%
  %%

  printf("Error: Write to SeqRAM 2 Failed.\n");

 } state Running
    }

    state Injecting {
 entry{

     %{




       }%

    %%
    StateMachineStatus = 3;
    pvPut(StateMachineStatus, SYNC);

    %%
    efClear(stopFlag);

    printf("Injecting Entry\n");
 }

 when(seqs == 1){

  %{ }%

     printf("Moving to Running State\n");
 } state Running

 when(efTestAndClear(stopInjFlag) && stopinj_tg){

  %{ }%

  %%
  if(seqs == 2){
     seqsw = 1;
     pvPut(seqsw, SYNC);
  }

     printf("Stop Inj Triggered\n");
 } state Injecting

 when(efTestAndClear(stopFlag) && stop_tg){

  %{ }%

  %%
  seqen = 0;
  pvPut(seqen, SYNC);

     printf("Stop Triggered\n");
 } state Injecting

 when(seqs == 0){

  %{ }%

  printf("Moving to Stopped State\n");
 } state Stopped
    }

    state Restarting{

 entry{

     %{






       }%

    %%
    StateMachineStatus = 4;
    pvPut(StateMachineStatus, SYNC);

    %%
    seqen = 0;
    pvPut(seqen, SYNC);

    %%
    for(i = 0; i < eventNum; i++){

  pvGet(event_codes[i], SYNC);
  pvGet(event_timestamps[i], SYNC);
  pvGet(event_modes[i], SYNC);
  pvGet(event_ctrl[i], SYNC);
    }

    %%
    updateEventPointerArray(eventNum, event_codes, event_timestamps, event_modes, event_ctrl);

    %%
    expandedEventNum = updateExpandedArray(train_enable, train_start_time, train_pulse_size,
       train_pulse_cnt, train_pulse_code, eventNum);

    %%
    numberOfWrites = 0;

    printf("Restarting Entry\n");
 }

 when(seqs == 0 && seqen_rbv == 0){

  %{ }%

  numberOfWrites = seqOneWrite(expandedEventNum, ssId, &seqaddr, &seqcode, &seqtime, &seqcount,
     pvIndex(seqaddr), pvIndex(seqcode), pvIndex(seqtime), pvIndex(seqcount));

 } state CheckSeq1Write


 when(seqs == 1 && seqen != 0){

  %{ }%

  printf("Moving to Running State\n");
 } state Running
    }
}

ss reset_tg_pv{
    state checking{

 when(stop_pv && delay(1.5)){
      %{ }%
  stop_pv = 0;
  pvPut(stop_pv, SYNC);
 } state checking

 when(run_pv && delay(1.5)){
      %{ }%
  run_pv = 0;
  pvPut(run_pv, SYNC);
 } state checking

 when(stopinj_pv && delay(1.5)){
     %{ }%
  stopinj_pv = 0;
  pvPut(stopinj_pv, SYNC);
 } state checking

 when(inj_pv && delay(1.5)){
     %{ }%
  inj_pv = 0;
  pvPut(inj_pv, SYNC);
 } state checking

 when(restart_pv && delay(1.5)){
     %{ }%
  restart_pv = 0;
  pvPut(restart_pv, SYNC);
 } state checking

 when(update_pv && delay(1.5)){
     %{ }%
  update_pv = 0;
  pvPut(update_pv, SYNC);
 } state checking
    }
}

%%
%%
%%

%{
# 781 "./../sncSeqRAM.stt"
 int str2int(char * str){

  int num = 0, i = 0;

  while(str[i] != '\0'){

   int aux = ch2int(str[i]);
   if(aux != -1){
    num *= 10;
    num += aux;
   }
   else{
    num = -1;
    break;
   }

   i++;
  }

  return num;
 }
# 812 "./../sncSeqRAM.stt"
 int ch2int(char ch){

  int num = 0;

  if(ch =='0')
   num = 0;
  else if(ch == '1')
   num = 1;
  else if(ch == '2')
   num = 2;
  else if(ch == '3')
   num = 3;
  else if(ch == '4')
   num = 4;
  else if(ch == '5')
   num = 5;
  else if(ch == '6')
   num = 6;
  else if(ch == '7')
   num = 7;
  else if(ch == '8')
   num = 8;
  else if(ch == '9')
   num = 9;
  else
   num = -1;

  return num;
 }
# 850 "./../sncSeqRAM.stt"
 void init_EventPointerArray(int size){

  int i;

  for(i = 0; i < size; i++){

   EventPointerArray[i] = &EventArray[i];
  }
 }
# 871 "./../sncSeqRAM.stt"
 int bubbleSort(Event* * evArray, int arraySize){

  int sorted = 0;
  int a, b;

  if(evArray == NULL){

   printf("Can't sort Event Array. Event array is null.\n");


   return 0;
  }


  for (a = 0; a < arraySize - 1; a++){

   sorted = 1;


   for (b = arraySize - 1; b > a; b--){


    if (evArray[b-1]->timestamp > evArray[b]->timestamp){

     swap(&evArray[b-1], &evArray[b]);
     sorted = 0;
    }


    if(evArray[b-1]->timestamp == evArray[b]->timestamp){

     evArray[b]->timestamp += 1;
     sorted = 0;
    }
   }


   if(sorted)
    break;
  }


  return 1;
 }
# 924 "./../sncSeqRAM.stt"
 void swap(Event* *a, Event* *b){

  Event * tmp;
  tmp = *a;
  *a = *b;
  *b = tmp;
 }
# 940 "./../sncSeqRAM.stt"
 void updateEventPointerArray(int evNumber, int * code_arr,
     int * time_arr, int * mode_arr, int * control_arr){

  int i;


  for(i = 0; i < evNumber; i++){

   EventPointerArray[i]->code = code_arr[i];
   EventPointerArray[i]->timestamp = time_arr[i];
   EventPointerArray[i]->mode = mode_arr[i];
   EventPointerArray[i]->ctrl = control_arr[i];
  }


  bubbleSort(EventPointerArray, evNumber);
 }
# 973 "./../sncSeqRAM.stt"
 int seqOneWrite(int evnum, SS_ID ssId, int *pseqaddr, int *pseqcode, int *pseqtime, int *pseqcount,
    VAR_ID seqaddr_id, VAR_ID seqcode_id, VAR_ID seqtime_id, VAR_ID seqcount_id){

  int i, maxdelay = 0, address = 0;


  int offSetEndCode = 10;

  for(i = 0; i < evnum; i++){


   if(ExpandedEventArray[i].ctrl != ALWAYS)
    continue;


   *pseqaddr = address;
   *pseqcode = ExpandedEventArray[i].code;
   *pseqtime = maxdelay = ExpandedEventArray[i].timestamp;


   seq_pvPut(ssId, seqaddr_id, SYNC);
   seq_pvPut(ssId, seqcode_id, SYNC);


   seq_pvPut(ssId, seqtime_id, SYNC);



   printf("Write to SeqRAM 1-> seqaddr= %d, seqcode= %d, seqtime= %d\n", *pseqaddr, *pseqcode, *pseqtime);




   address++;
  }




  *pseqaddr = address;
  *pseqcode = 0x7F;
  *pseqtime = maxdelay + offSetEndCode;


  seq_pvPut(ssId, seqaddr_id, SYNC);
  seq_pvPut(ssId, seqcode_id, SYNC);


  seq_pvPut(ssId, seqtime_id, SYNC);



  printf("Write to SeqRAM 1-> seqaddr= %d, seqcode= %d, seqtime= %d\n", *pseqaddr, *pseqcode, *pseqtime);





  address++;


       return address;
 }
# 1053 "./../sncSeqRAM.stt"
 int seqTwoWrite(int evnum, int TBL[], int length, SS_ID ssId, int *pseqaddr, int *pseqcode,
   int *pseqtime, int *pseqcount, VAR_ID seqaddr_id, VAR_ID seqcode_id, VAR_ID seqtime_id, VAR_ID seqcount_id){

  int i, j, seqdly, rfdly, maxdelay = 0, address = 0;


  int offSetEndCode = 10;


  int RFDlyTimestamp = 10;


  for(i = 0; i < length; i++){


   seqdly = TBL[i] / 4;
   rfdly = TBL[i] % 4;



   *pseqaddr = address;
   *pseqcode = 0x40 + rfdly * 5;
   *pseqtime = RFDlyTimestamp;


   seq_pvPut(ssId, seqaddr_id, SYNC);
   seq_pvPut(ssId, seqcode_id, SYNC);


   seq_pvPut(ssId, seqtime_id, SYNC);



   printf("Write to SeqRAM 2-> seqaddr= %d, seqcode= %d, seqtime= %d\n", *pseqaddr, *pseqcode, *pseqtime);





   address++;


   for(j = 0; j < evnum; j++){


    if(ExpandedEventArray[j].mode == INCR){


     *pseqtime = maxdelay = ExpandedEventArray[j].timestamp + seqdly;
    }
    else{


     *pseqtime = maxdelay = ExpandedEventArray[j].timestamp;
    }




    *pseqaddr = address;
    *pseqcode = ExpandedEventArray[j].code;


    seq_pvPut(ssId, seqaddr_id, SYNC);
    seq_pvPut(ssId, seqcode_id, SYNC);


    seq_pvPut(ssId, seqtime_id, SYNC);



    printf("Write to SeqRAM 2-> seqaddr= %d, seqcode= %d, seqtime= %d\n", *pseqaddr, *pseqcode, *pseqtime);





    address++;

   }


   if(i < length - 1){

    *pseqcode = 0x70;


    *pseqaddr = address;
    *pseqtime = maxdelay + offSetEndCode;


    seq_pvPut(ssId, seqaddr_id, SYNC);
    seq_pvPut(ssId, seqcode_id, SYNC);


    seq_pvPut(ssId, seqtime_id, SYNC);



    printf("Write to SeqRAM 2-> seqaddr= %d, seqcode= %d, seqtime= %d\n", *pseqaddr, *pseqcode, *pseqtime);





    address++;
   }
  }


  *pseqcode = 0x7E;


  *pseqaddr = address;
  *pseqtime = maxdelay + offSetEndCode;


  seq_pvPut(ssId, seqaddr_id, SYNC);
  seq_pvPut(ssId, seqcode_id, SYNC);


  seq_pvPut(ssId, seqtime_id, SYNC);



  printf("Write to SeqRAM 2-> seqaddr= %d, seqcode= %d, seqtime= %d\n", *pseqaddr, *pseqcode, *pseqtime);




  address++;


         return address;
 }
# 1200 "./../sncSeqRAM.stt"
 int expandArray(int evnum, int trainEnable, int pulseCnt, int trainDuration, int trainStart, int trainCode){

  int i, j;


  int expIndex = 0;


  int pulseInterval = trainDuration / pulseCnt;
  int pulseTime = trainStart;
  int pulsesLeft = 0;


  if(trainEnable == 0 || pulseCnt == 0){


   for(i = 0; i < evnum; i++){

    ExpandedEventArray[expIndex].code = EventPointerArray[i]->code;
    ExpandedEventArray[expIndex].timestamp = EventPointerArray[i]->timestamp;
    ExpandedEventArray[expIndex].mode = EventPointerArray[i]->mode;
    ExpandedEventArray[expIndex].ctrl = EventPointerArray[i]->ctrl;

    expIndex++;
   }


   return expIndex;
  }



  for(i = 0; i < evnum; i++){


   if(trainStart == pulseTime && EventPointerArray[i]->timestamp > trainStart){

    pulsesLeft = pulseCnt;
   }


   if(pulsesLeft > 0){



    int n = 0;

    if(pulseTime < EventPointerArray[i]->timestamp)
     n = floor((EventPointerArray[i]->timestamp - pulseTime) / pulseInterval) + 1;

    if(n > pulsesLeft) n = pulsesLeft;


    for(j = 0; j < n; j++){

     ExpandedEventArray[expIndex].code = trainCode;

     ExpandedEventArray[expIndex].timestamp = pulseTime;
     pulseTime += pulseInterval;

     ExpandedEventArray[expIndex].mode = INCR;
     ExpandedEventArray[expIndex].ctrl = ALWAYS;


     expIndex++;
    }


    pulsesLeft -= n;
   }


   ExpandedEventArray[expIndex].code = EventPointerArray[i]->code;
   ExpandedEventArray[expIndex].timestamp = EventPointerArray[i]->timestamp;
   ExpandedEventArray[expIndex].mode = EventPointerArray[i]->mode;
   ExpandedEventArray[expIndex].ctrl = EventPointerArray[i]->ctrl;


   expIndex++;
  }


  if(trainStart == pulseTime)
   pulsesLeft = pulseCnt;


  for(i = 0; i < pulsesLeft; i++){

   ExpandedEventArray[expIndex].code = trainCode;
   ExpandedEventArray[expIndex].timestamp = pulseTime;
   pulseTime += pulseInterval;
   ExpandedEventArray[expIndex].mode = INCR;
   ExpandedEventArray[expIndex].ctrl = ALWAYS;


   expIndex++;
  }


  return expIndex;
 }
# 1314 "./../sncSeqRAM.stt"
 int trainStartCorrection(int trainEnable, int trainStart, int trainDuration, int pulseCnt, int evnum) {

  if(!trainEnable) return trainStart;

  int i;

  int interval = trainDuration/pulseCnt;

      for(i = evnum-1; i >= 0; i--){

   int diff = EventPointerArray[i]->timestamp - trainStart;

   if(diff >= 0 && !(diff % interval))
    trainStart--;
  }


  if(trainStart < 0) trainStart = 0;


  return trainStart;
 }
# 1351 "./../sncSeqRAM.stt"
 int updateExpandedArray(int trainEnable, int trainStart, int trainDuration, int pulseCnt, int trainCode, int evnum){


  trainStart = trainStartCorrection(trainEnable, trainStart, trainDuration, pulseCnt, evnum);


  int newNumEvents = expandArray(evnum, trainEnable, pulseCnt, trainDuration, trainStart, trainCode);

  return newNumEvents;
 }
}%
# 1 "../sncSeqRAMProgram.st" 2
