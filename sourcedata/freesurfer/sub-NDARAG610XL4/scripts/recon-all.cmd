

#---------------------------------
# New invocation of recon-all Fri Dec 10 19:45:06 UTC 2021 

 mri_convert /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/workdir/fmriprep_wf/single_subject_NDARAG610XL4_wf/anat_preproc_wf/anat_validate/sub-NDARAG610XL4_ses-HBNsiteCBIC_acq-VNavNorm_T1w_ras_valid.nii.gz /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/orig/001.mgz 

#--------------------------------------------
#@# T2/FLAIR Input Fri Dec 10 19:45:15 UTC 2021

 mri_convert --no_scale 1 /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/bids/sub-NDARAG610XL4/ses-HBNsiteCBIC/anat/sub-NDARAG610XL4_ses-HBNsiteCBIC_acq-VNavNorm_T2w.nii.gz /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/orig/T2raw.mgz 

#--------------------------------------------
#@# MotionCor Fri Dec 10 19:45:19 UTC 2021

 cp /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/orig/001.mgz /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/rawavg.mgz 


 mri_convert /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/rawavg.mgz /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/orig.mgz --conform 


 mri_add_xform_to_header -c /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/transforms/talairach.xfm /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/orig.mgz /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/orig.mgz 

#--------------------------------------------
#@# Talairach Fri Dec 10 19:45:28 UTC 2021

 mri_nu_correct.mni --no-rescale --i orig.mgz --o orig_nu.mgz --n 1 --proto-iters 1000 --distance 50 


 talairach_avi --i orig_nu.mgz --xfm transforms/talairach.auto.xfm 

talairach_avi log file is transforms/talairach_avi.log...

 cp transforms/talairach.auto.xfm transforms/talairach.xfm 

#--------------------------------------------
#@# Talairach Failure Detection Fri Dec 10 19:48:19 UTC 2021

 talairach_afd -T 0.005 -xfm transforms/talairach.xfm 


 awk -f /opt/freesurfer/bin/extract_talairach_avi_QA.awk /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/transforms/talairach_avi.log 


 tal_QC_AZS /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/transforms/talairach_avi.log 

#--------------------------------------------
#@# Nu Intensity Correction Fri Dec 10 19:48:19 UTC 2021

 mri_nu_correct.mni --i orig.mgz --o nu.mgz --uchar transforms/talairach.xfm --n 2 


 mri_add_xform_to_header -c /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/transforms/talairach.xfm nu.mgz nu.mgz 

#--------------------------------------------
#@# Intensity Normalization Fri Dec 10 19:51:24 UTC 2021

 mri_normalize -g 1 -mprage nu.mgz T1.mgz 



#---------------------------------
# New invocation of recon-all Fri Dec 10 20:06:53 UTC 2021 
#-------------------------------------
#@# EM Registration Fri Dec 10 20:06:54 UTC 2021

 mri_em_register -rusage /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/touch/rusage.mri_em_register.dat -uns 3 -mask brainmask.mgz nu.mgz /opt/freesurfer/average/RB_all_2016-05-10.vc700.gca transforms/talairach.lta 

#--------------------------------------
#@# CA Normalize Fri Dec 10 20:12:03 UTC 2021

 mri_ca_normalize -c ctrl_pts.mgz -mask brainmask.mgz nu.mgz /opt/freesurfer/average/RB_all_2016-05-10.vc700.gca transforms/talairach.lta norm.mgz 

#--------------------------------------
#@# CA Reg Fri Dec 10 20:13:17 UTC 2021

 mri_ca_register -rusage /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/touch/rusage.mri_ca_register.dat -nobigventricles -T transforms/talairach.lta -align-after -mask brainmask.mgz norm.mgz /opt/freesurfer/average/RB_all_2016-05-10.vc700.gca transforms/talairach.m3z 

#--------------------------------------
#@# SubCort Seg Fri Dec 10 21:30:24 UTC 2021

 mri_ca_label -relabel_unlikely 9 .3 -prior 0.5 -align norm.mgz transforms/talairach.m3z /opt/freesurfer/average/RB_all_2016-05-10.vc700.gca aseg.auto_noCCseg.mgz 


 mri_cc -aseg aseg.auto_noCCseg.mgz -o aseg.auto.mgz -lta /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/transforms/cc_up.lta sub-NDARAG610XL4 

#--------------------------------------
#@# Merge ASeg Fri Dec 10 22:11:40 UTC 2021

 cp aseg.auto.mgz aseg.presurf.mgz 

#--------------------------------------------
#@# Intensity Normalization2 Fri Dec 10 22:11:40 UTC 2021

 mri_normalize -mprage -aseg aseg.presurf.mgz -mask brainmask.mgz norm.mgz brain.mgz 

#--------------------------------------------
#@# Mask BFS Fri Dec 10 22:13:41 UTC 2021

 mri_mask -T 5 brain.mgz brainmask.mgz brain.finalsurfs.mgz 

#--------------------------------------------
#@# WM Segmentation Fri Dec 10 22:13:44 UTC 2021

 mri_segment -mprage brain.mgz wm.seg.mgz 


 mri_edit_wm_with_aseg -keep-in wm.seg.mgz brain.mgz aseg.presurf.mgz wm.asegedit.mgz 


 mri_pretess wm.asegedit.mgz wm norm.mgz wm.mgz 

#--------------------------------------------
#@# Fill Fri Dec 10 22:15:24 UTC 2021

 mri_fill -a ../scripts/ponscc.cut.log -xform transforms/talairach.lta -segmentation aseg.auto_noCCseg.mgz wm.mgz filled.mgz 



#---------------------------------
# New invocation of recon-all Sat Dec 11 01:22:38 UTC 2021 
#--------------------------------------------
#@# Refine Pial Surfs w/ T2/FLAIR Sat Dec 11 01:22:39 UTC 2021

 bbregister --s sub-NDARAG610XL4 --mov /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/orig/T2raw.mgz --lta /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/transforms/T2raw.auto.lta --init-coreg --T2 


 cp /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/transforms/T2raw.auto.lta /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/transforms/T2raw.lta 


 mri_convert -odt float -at /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/transforms/T2raw.lta -rl /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/orig.mgz /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/orig/T2raw.mgz /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/T2.prenorm.mgz 


 mri_normalize -sigma 0.5 -nonmax_suppress 0 -min_dist 1 -aseg /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/aseg.presurf.mgz -surface /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/surf/rh.white identity.nofile -surface /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/surf/lh.white identity.nofile /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/T2.prenorm.mgz /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/T2.norm.mgz 


 mri_mask /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/T2.norm.mgz /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/brainmask.mgz /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/mri/T2.mgz 


 cp -v /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/surf/lh.pial /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/surf/lh.woT2.pial 


 mris_make_surfaces -orig_white white -orig_pial woT2.pial -aseg ../mri/aseg.presurf -nowhite -mgz -T1 brain.finalsurfs -T2 ../mri/T2 -nsigma_above 2 -nsigma_below 5 sub-NDARAG610XL4 lh 


 cp -v /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/surf/rh.pial /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/surf/rh.woT2.pial 


 mris_make_surfaces -orig_white white -orig_pial woT2.pial -aseg ../mri/aseg.presurf -nowhite -mgz -T1 brain.finalsurfs -T2 ../mri/T2 -nsigma_above 2 -nsigma_below 5 sub-NDARAG610XL4 rh 

#--------------------------------------------
#@# Surf Volume lh Sat Dec 11 01:53:40 UTC 2021

 vertexvol --s sub-NDARAG610XL4 --lh --th3 

#--------------------------------------------
#@# Surf Volume rh Sat Dec 11 01:53:42 UTC 2021

 vertexvol --s sub-NDARAG610XL4 --rh --th3 

#--------------------------------------------
#@# Surf Volume lh Sat Dec 11 01:53:45 UTC 2021
#--------------------------------------------
#@# Surf Volume rh Sat Dec 11 01:53:47 UTC 2021
#--------------------------------------------
#@# Cortical ribbon mask Sat Dec 11 01:53:50 UTC 2021

 mris_volmask --aseg_name aseg.presurf --label_left_white 2 --label_left_ribbon 3 --label_right_white 41 --label_right_ribbon 42 --save_ribbon sub-NDARAG610XL4 



#---------------------------------
# New invocation of recon-all Sat Dec 11 02:05:27 UTC 2021 
#-----------------------------------------
#@# Relabel Hypointensities Sat Dec 11 02:05:27 UTC 2021

 mri_relabel_hypointensities aseg.presurf.mgz ../surf aseg.presurf.hypos.mgz 

#-----------------------------------------
#@# AParc-to-ASeg aparc Sat Dec 11 02:05:42 UTC 2021

 mri_aparc2aseg --s sub-NDARAG610XL4 --volmask --aseg aseg.presurf.hypos --relabel mri/norm.mgz mri/transforms/talairach.m3z /opt/freesurfer/average/RB_all_2016-05-10.vc700.gca mri/aseg.auto_noCCseg.label_intensities.txt 

#-----------------------------------------
#@# AParc-to-ASeg a2009s Sat Dec 11 02:09:00 UTC 2021

 mri_aparc2aseg --s sub-NDARAG610XL4 --volmask --aseg aseg.presurf.hypos --relabel mri/norm.mgz mri/transforms/talairach.m3z /opt/freesurfer/average/RB_all_2016-05-10.vc700.gca mri/aseg.auto_noCCseg.label_intensities.txt --a2009s 

#-----------------------------------------
#@# AParc-to-ASeg DKTatlas Sat Dec 11 02:12:19 UTC 2021

 mri_aparc2aseg --s sub-NDARAG610XL4 --volmask --aseg aseg.presurf.hypos --relabel mri/norm.mgz mri/transforms/talairach.m3z /opt/freesurfer/average/RB_all_2016-05-10.vc700.gca mri/aseg.auto_noCCseg.label_intensities.txt --annot aparc.DKTatlas --o mri/aparc.DKTatlas+aseg.mgz 

#-----------------------------------------
#@# APas-to-ASeg Sat Dec 11 02:15:41 UTC 2021

 apas2aseg --i aparc+aseg.mgz --o aseg.mgz 

#--------------------------------------------
#@# ASeg Stats Sat Dec 11 02:15:45 UTC 2021

 mri_segstats --seg mri/aseg.mgz --sum stats/aseg.stats --pv mri/norm.mgz --empty --brainmask mri/brainmask.mgz --brain-vol-from-seg --excludeid 0 --excl-ctxgmwm --supratent --subcortgray --in mri/norm.mgz --in-intensity-name norm --in-intensity-units MR --etiv --surf-wm-vol --surf-ctx-vol --totalgray --euler --ctab /opt/freesurfer/ASegStatsLUT.txt --subject sub-NDARAG610XL4 

#-----------------------------------------
#@# WMParc Sat Dec 11 02:16:25 UTC 2021

 mri_aparc2aseg --s sub-NDARAG610XL4 --labelwm --hypo-as-wm --rip-unknown --volmask --o mri/wmparc.mgz --ctxseg aparc+aseg.mgz 


 mri_segstats --seg mri/wmparc.mgz --sum stats/wmparc.stats --pv mri/norm.mgz --excludeid 0 --brainmask mri/brainmask.mgz --in mri/norm.mgz --in-intensity-name norm --in-intensity-units MR --subject sub-NDARAG610XL4 --surf-wm-vol --ctab /opt/freesurfer/WMParcStatsLUT.txt --etiv 

