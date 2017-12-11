# Specify save file path
set_savefile_path("$(TOP)", "autosave/save_files")

# Specify request files directories
set_requestfile_path("$(TOP)", "autosave/request_files")

# Specify files to be restored, and when
# EVG
${EVG1_line}set_pass0_restoreFile("autosave_evg_NOPROC.sav")
# ITBL
${EVG1_line}set_pass1_restoreFile("autosave_ITBL_PROC.sav")
# Events
${EVG1_line}set_pass1_restoreFile("autosave_event0_PROC.sav")
${EVG1_line}set_pass1_restoreFile("autosave_event1_PROC.sav")
${EVG1_line}set_pass1_restoreFile("autosave_event2_PROC.sav")
${EVG1_line}set_pass1_restoreFile("autosave_event3_PROC.sav")
${EVG1_line}set_pass1_restoreFile("autosave_event4_PROC.sav")
${EVG1_line}set_pass1_restoreFile("autosave_event5_PROC.sav")
${EVG1_line}set_pass1_restoreFile("autosave_event6_PROC.sav")
${EVG1_line}set_pass1_restoreFile("autosave_event7_PROC.sav")
${EVG1_line}set_pass1_restoreFile("autosave_event8_PROC.sav")
${EVG1_line}set_pass1_restoreFile("autosave_event9_PROC.sav")
${EVG1_line}set_pass1_restoreFile("autosave_event10_PROC.sav")
${EVG1_line}set_pass1_restoreFile("autosave_event11_PROC.sav")
${EVG1_line}set_pass1_restoreFile("autosave_event12_PROC.sav")
${EVG1_line}set_pass1_restoreFile("autosave_event13_PROC.sav")
${EVG1_line}set_pass1_restoreFile("autosave_event14_PROC.sav")
${EVG1_line}set_pass1_restoreFile("autosave_event15_PROC.sav")
# EVR
${EVR1_line}set_pass0_restoreFile("autosave_evr1_NOPROC.sav")
${EVR2_line}set_pass0_restoreFile("autosave_evr2_NOPROC.sav")
${EVR3_line}set_pass0_restoreFile("autosave_evr3_NOPROC.sav")
${EVR4_line}set_pass0_restoreFile("autosave_evr4_NOPROC.sav")
${EVR5_line}set_pass0_restoreFile("autosave_evr5_NOPROC.sav")
${EVR6_line}set_pass0_restoreFile("autosave_evr6_NOPROC.sav")
# EVE
${EVE1_line}set_pass0_restoreFile("autosave_eve1_NOPROC.sav")
${EVE2_line}set_pass0_restoreFile("autosave_eve2_NOPROC.sav")
${EVE3_line}set_pass0_restoreFile("autosave_eve3_NOPROC.sav")
${EVE4_line}set_pass0_restoreFile("autosave_eve4_NOPROC.sav")
# FOUT
${FOUT1_line}set_pass0_restoreFile("autosave_fout1_NOPROC.sav")
${FOUT2_line}set_pass0_restoreFile("autosave_fout2_NOPROC.sav")
${FOUT3_line}set_pass0_restoreFile("autosave_fout3_NOPROC.sav")
${FOUT4_line}set_pass0_restoreFile("autosave_fout4_NOPROC.sav")
${FOUT5_line}set_pass0_restoreFile("autosave_fout5_NOPROC.sav")

# Enable/Disable backup files (0->Disable, 1->Enable)
save_restoreSet_DatedBackupFiles(0)

# Number of copies of .sav files to maintain
save_restoreSet_NumSeqFiles(0)

