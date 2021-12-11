

#---------------------------------
# New invocation of recon-all Fri Dec 10 22:15:56 UTC 2021 
#--------------------------------------------
#@# Tessellate rh Fri Dec 10 22:15:57 UTC 2021

 mri_pretess ../mri/filled.mgz 127 ../mri/norm.mgz ../mri/filled-pretess127.mgz 


 mri_tessellate ../mri/filled-pretess127.mgz 127 ../surf/rh.orig.nofix 


 rm -f ../mri/filled-pretess127.mgz 


 mris_extract_main_component ../surf/rh.orig.nofix ../surf/rh.orig.nofix 

#--------------------------------------------
#@# Smooth1 rh Fri Dec 10 22:16:02 UTC 2021

 mris_smooth -nw -seed 1234 ../surf/rh.orig.nofix ../surf/rh.smoothwm.nofix 

#--------------------------------------------
#@# Inflation1 rh Fri Dec 10 22:16:07 UTC 2021

 mris_inflate -no-save-sulc ../surf/rh.smoothwm.nofix ../surf/rh.inflated.nofix 

#--------------------------------------------
#@# QSphere rh Fri Dec 10 22:16:36 UTC 2021

 mris_sphere -q -seed 1234 ../surf/rh.inflated.nofix ../surf/rh.qsphere.nofix 

#--------------------------------------------
#@# Fix Topology Copy rh Fri Dec 10 22:18:16 UTC 2021

 cp ../surf/rh.orig.nofix ../surf/rh.orig 


 cp ../surf/rh.inflated.nofix ../surf/rh.inflated 

#@# Fix Topology rh Fri Dec 10 22:18:16 UTC 2021

 mris_fix_topology -rusage /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/touch/rusage.mris_fix_topology.rh.dat -mgz -sphere qsphere.nofix -ga -seed 1234 sub-NDARAG610XL4 rh 


 mris_euler_number ../surf/rh.orig 


 mris_remove_intersection ../surf/rh.orig ../surf/rh.orig 


 rm ../surf/rh.inflated 

#--------------------------------------------
#@# Make White Surf rh Sat Dec 11 00:11:10 UTC 2021

 mris_make_surfaces -aseg ../mri/aseg.presurf -white white.preaparc -noaparc -whiteonly -mgz -T1 brain.finalsurfs sub-NDARAG610XL4 rh 

#--------------------------------------------
#@# Smooth2 rh Sat Dec 11 00:14:39 UTC 2021

 mris_smooth -n 3 -nw -seed 1234 ../surf/rh.white.preaparc ../surf/rh.smoothwm 

#--------------------------------------------
#@# Inflation2 rh Sat Dec 11 00:14:45 UTC 2021

 mris_inflate -rusage /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/touch/rusage.mris_inflate.rh.dat ../surf/rh.smoothwm ../surf/rh.inflated 

#--------------------------------------------
#@# Curv .H and .K rh Sat Dec 11 00:15:06 UTC 2021

 mris_curvature -w rh.white.preaparc 


 mris_curvature -thresh .999 -n -a 5 -w -distances 10 10 rh.inflated 


#-----------------------------------------
#@# Curvature Stats rh Sat Dec 11 00:16:09 UTC 2021

 mris_curvature_stats -m --writeCurvatureFiles -G -o ../stats/rh.curv.stats -F smoothwm sub-NDARAG610XL4 rh curv sulc 

#--------------------------------------------
#@# Sphere rh Sat Dec 11 00:16:12 UTC 2021

 mris_sphere -rusage /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/touch/rusage.mris_sphere.rh.dat -seed 1234 ../surf/rh.inflated ../surf/rh.sphere 

#--------------------------------------------
#@# Surf Reg rh Sat Dec 11 00:32:21 UTC 2021

 mris_register -curv -rusage /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/sub-NDARAG610XL4/touch/rusage.mris_register.rh.dat ../surf/rh.sphere /opt/freesurfer/average/rh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif ../surf/rh.sphere.reg 

#--------------------------------------------
#@# Jacobian white rh Sat Dec 11 01:11:53 UTC 2021

 mris_jacobian ../surf/rh.white.preaparc ../surf/rh.sphere.reg ../surf/rh.jacobian_white 

#--------------------------------------------
#@# AvgCurv rh Sat Dec 11 01:11:54 UTC 2021

 mrisp_paint -a 5 /opt/freesurfer/average/rh.folding.atlas.acfb40.noaparc.i12.2016-08-02.tif#6 ../surf/rh.sphere.reg ../surf/rh.avg_curv 

#-----------------------------------------
#@# Cortical Parc rh Sat Dec 11 01:11:56 UTC 2021

 mris_ca_label -l ../label/rh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-NDARAG610XL4 rh ../surf/rh.sphere.reg /opt/freesurfer/average/rh.DKaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/rh.aparc.annot 

#--------------------------------------------
#@# Make Pial Surf rh Sat Dec 11 01:12:05 UTC 2021

 mris_make_surfaces -orig_white white.preaparc -orig_pial white.preaparc -aseg ../mri/aseg.presurf -mgz -T1 brain.finalsurfs sub-NDARAG610XL4 rh 

#--------------------------------------------
#@# Surf Volume rh Sat Dec 11 01:22:05 UTC 2021
#-----------------------------------------
#@# Cortical Parc 2 rh Sat Dec 11 01:22:07 UTC 2021

 mris_ca_label -l ../label/rh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-NDARAG610XL4 rh ../surf/rh.sphere.reg /opt/freesurfer/average/rh.CDaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/rh.aparc.a2009s.annot 

#-----------------------------------------
#@# Cortical Parc 3 rh Sat Dec 11 01:22:20 UTC 2021

 mris_ca_label -l ../label/rh.cortex.label -aseg ../mri/aseg.presurf.mgz -seed 1234 sub-NDARAG610XL4 rh ../surf/rh.sphere.reg /opt/freesurfer/average/rh.DKTaparc.atlas.acfb40.noaparc.i12.2016-08-02.gcs ../label/rh.aparc.DKTatlas.annot 

#-----------------------------------------
#@# WM/GM Contrast rh Sat Dec 11 01:22:30 UTC 2021

 pctsurfcon --s sub-NDARAG610XL4 --rh-only 



#---------------------------------
# New invocation of recon-all Sat Dec 11 01:59:38 UTC 2021 
#-----------------------------------------
#@# Parcellation Stats rh Sat Dec 11 01:59:39 UTC 2021

 mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.stats -b -a ../label/rh.aparc.annot -c ../label/aparc.annot.ctab sub-NDARAG610XL4 rh white 


 mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.pial.stats -b -a ../label/rh.aparc.annot -c ../label/aparc.annot.ctab sub-NDARAG610XL4 rh pial 

#-----------------------------------------
#@# Parcellation Stats 2 rh Sat Dec 11 02:00:34 UTC 2021

 mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.a2009s.stats -b -a ../label/rh.aparc.a2009s.annot -c ../label/aparc.annot.a2009s.ctab sub-NDARAG610XL4 rh white 

#-----------------------------------------
#@# Parcellation Stats 3 rh Sat Dec 11 02:00:59 UTC 2021

 mris_anatomical_stats -th3 -mgz -cortex ../label/rh.cortex.label -f ../stats/rh.aparc.DKTatlas.stats -b -a ../label/rh.aparc.DKTatlas.annot -c ../label/aparc.annot.DKTatlas.ctab sub-NDARAG610XL4 rh white 

#--------------------------------------------
#@# BA_exvivo Labels rh Sat Dec 11 02:01:24 UTC 2021

 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.BA1_exvivo.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.BA1_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.BA2_exvivo.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.BA2_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.BA3a_exvivo.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.BA3a_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.BA3b_exvivo.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.BA3b_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.BA4a_exvivo.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.BA4a_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.BA4p_exvivo.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.BA4p_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.BA6_exvivo.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.BA6_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.BA44_exvivo.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.BA44_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.BA45_exvivo.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.BA45_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.V1_exvivo.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.V1_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.V2_exvivo.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.V2_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.MT_exvivo.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.MT_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.entorhinal_exvivo.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.entorhinal_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.perirhinal_exvivo.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.perirhinal_exvivo.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.BA1_exvivo.thresh.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.BA1_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.BA2_exvivo.thresh.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.BA2_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.BA3a_exvivo.thresh.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.BA3a_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.BA3b_exvivo.thresh.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.BA3b_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.BA4a_exvivo.thresh.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.BA4a_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.BA4p_exvivo.thresh.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.BA4p_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.BA6_exvivo.thresh.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.BA6_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.BA44_exvivo.thresh.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.BA44_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.BA45_exvivo.thresh.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.BA45_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.V1_exvivo.thresh.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.V1_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.V2_exvivo.thresh.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.V2_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.MT_exvivo.thresh.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.MT_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.entorhinal_exvivo.thresh.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.entorhinal_exvivo.thresh.label --hemi rh --regmethod surface 


 mri_label2label --srcsubject fsaverage --srclabel /mnt/datasets/datalad/crawl-misc/hbn-ls/HBN_BIDS-fmriprep_try1/sourcedata/freesurfer/fsaverage/label/rh.perirhinal_exvivo.thresh.label --trgsubject sub-NDARAG610XL4 --trglabel ./rh.perirhinal_exvivo.thresh.label --hemi rh --regmethod surface 


 mris_label2annot --s sub-NDARAG610XL4 --hemi rh --ctab /opt/freesurfer/average/colortable_BA.txt --l rh.BA1_exvivo.label --l rh.BA2_exvivo.label --l rh.BA3a_exvivo.label --l rh.BA3b_exvivo.label --l rh.BA4a_exvivo.label --l rh.BA4p_exvivo.label --l rh.BA6_exvivo.label --l rh.BA44_exvivo.label --l rh.BA45_exvivo.label --l rh.V1_exvivo.label --l rh.V2_exvivo.label --l rh.MT_exvivo.label --l rh.entorhinal_exvivo.label --l rh.perirhinal_exvivo.label --a BA_exvivo --maxstatwinner --noverbose 


 mris_label2annot --s sub-NDARAG610XL4 --hemi rh --ctab /opt/freesurfer/average/colortable_BA.txt --l rh.BA1_exvivo.thresh.label --l rh.BA2_exvivo.thresh.label --l rh.BA3a_exvivo.thresh.label --l rh.BA3b_exvivo.thresh.label --l rh.BA4a_exvivo.thresh.label --l rh.BA4p_exvivo.thresh.label --l rh.BA6_exvivo.thresh.label --l rh.BA44_exvivo.thresh.label --l rh.BA45_exvivo.thresh.label --l rh.V1_exvivo.thresh.label --l rh.V2_exvivo.thresh.label --l rh.MT_exvivo.thresh.label --l rh.entorhinal_exvivo.thresh.label --l rh.perirhinal_exvivo.thresh.label --a BA_exvivo.thresh --maxstatwinner --noverbose 


 mris_anatomical_stats -th3 -mgz -f ../stats/rh.BA_exvivo.stats -b -a ./rh.BA_exvivo.annot -c ./BA_exvivo.ctab sub-NDARAG610XL4 rh white 


 mris_anatomical_stats -th3 -mgz -f ../stats/rh.BA_exvivo.thresh.stats -b -a ./rh.BA_exvivo.thresh.annot -c ./BA_exvivo.thresh.ctab sub-NDARAG610XL4 rh white 

