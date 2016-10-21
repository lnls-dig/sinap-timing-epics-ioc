# 1 "../sncModuleProgram.st"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "../sncModuleProgram.st"
# 1 "./../sncModuleSupport.stt" 1
program sncModuleSupport

int uploadproc;
assign uploadproc to "{device}:uploadT.PROC";

int downloadproc;
assign downloadproc to "{device}:downloadT.PROC";

int download;
assign download to "{device}:download.VAL";
monitor download;

int statdev;
assign statdev to "{device}:statdev";
monitor statdev;

int past_alive = -1;
int alive;
assign alive to "{device}:alive";
monitor alive;

int funselRBV;
assign funselRBV to "{device}:funselRBV";
monitor funselRBV;

int network;
assign network to "{device}:network";

ss configuration {
    state init {
  when (delay(1.0)){
   printf("\n%s state machine initiated\n", macValueGet("device"));
  } state upload
    }
    state upload {
  when (statdev == 0){
  } state waiting
  when (network == 1){
   uploadproc = 1;
   pvPut(uploadproc,SYNC);
   printf("\nConfiguration uploaded from %s.\n", macValueGet("device"));
  } state waiting
  when (delay(2.0)) {
  } state upload
    }
    state waiting {
  when ((statdev == 0) && (network == 1)) {
   download = 1;
  } state download
  when ((download == 1) && (network == 1)) {
   download = 1;
  } state download
  when (delay(1)) {
  } state waiting
 }

 state download {
  entry {
   downloadproc = 1;
   pvPut(downloadproc,SYNC);
   printf("\nConfiguration downloaded to %s.\n", macValueGet("device"));
   download = 0;
   pvPut(download,SYNC);
  }
  when (delay(1)) {
  }state waiting
 }
}

ss networkStatus {
 state networkCheck {
  when (delay(2.0)) {
   if (funselRBV == 0) {
    past_alive = -1;
    network = 0;
    pvPut(network,SYNC);
   }
   else if (statdev == 0) {
    past_alive = -1;
    network = 1;
    pvPut(network,SYNC);
   }
   else if (alive > past_alive) {
    past_alive = alive;
    network = 1;
    pvPut(network,SYNC);
   }
   else {
    past_alive = alive;
    network = 0;
    pvPut(network,SYNC);
   }
  } state networkCheck
 }
}
# 2 "../sncModuleProgram.st" 2
