# CHANGELOG



## v1.3.1 (2024-01-31)

### Build

* build: Update artifact destination for production ([`e05d487`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e05d487db2eea2ebdb9c7586ea9f5f05a93b0d04))

### Fix

* fix: Update version in DESCRIPTION, update package name in meta.yaml, and rm tar.gz in package ([`092ecfb`](https://github.com/NIDAP-Community/DSPWorkflow/commit/092ecfbee3c1d8b7264f1297a94bf06e64c266e9))

### Unknown

* Merge pull request #143 from NIDAP-Community/dev

Removed tarballs, updated version number and Conda package name ([`6787e97`](https://github.com/NIDAP-Community/DSPWorkflow/commit/6787e97e6de6a722ed233b0c2a5dbde650017ea0))

* Merge pull request #142 from NIDAP-Community/update_cd

build: Update artifact destination for production ([`f0e24ad`](https://github.com/NIDAP-Community/DSPWorkflow/commit/f0e24adfb614ae3b540b10f3005c811447b9b75b))

* Merge pull request #140 from NIDAP-Community/update_cd

fix: Update version in DESCRIPTION, update package name in meta.yaml,… ([`485131c`](https://github.com/NIDAP-Community/DSPWorkflow/commit/485131cd230532fc22da0dc6da17dd2af956751a))


## v1.3.0 (2024-01-30)

### Documentation

* docs(version): Automatic development release ([`0f85910`](https://github.com/NIDAP-Community/DSPWorkflow/commit/0f85910f4f73f6929f2c7c63047a73a6be6ce2d6))

### Feature

* feat: CI/CD and Conda Recipe ([`ae18de3`](https://github.com/NIDAP-Community/DSPWorkflow/commit/ae18de32dabd4e49911863f638ef930c631e4e85))

* feat: Updates to QC flag print out and associated markdown vignettes, tests, and fixtures ([`f3f5879`](https://github.com/NIDAP-Community/DSPWorkflow/commit/f3f587989115314831f4941bd2309b45e1a85780))

* feat: QC output for specific flagged segments and probes ([`6f434ab`](https://github.com/NIDAP-Community/DSPWorkflow/commit/6f434ab473eb67fc1dbdcf91047021a8d6ba9fe7))

* feat(segmentID list): Added initial list of segment IDs before filtering ([`3f6c011`](https://github.com/NIDAP-Community/DSPWorkflow/commit/3f6c0111d639861e3e39a7f804d5489ece837c3c))

* feat(DEG): Added linear model (no random effect) in DEG analysis and adjusted output table ([`e995733`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e9957334696f3b0e40cb99597b94ac54a0d43e0f))

### Fix

* fix(docs): Updated function documentation ([`d69b216`](https://github.com/NIDAP-Community/DSPWorkflow/commit/d69b216e3bc540bc54006dfedf7b1ae634fc0bb9))

* fix(filtering): Updates for sankey plot in filtering ([`995b40d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/995b40d4c43573391602e61c83de42fd8600780c))

* fix(study design): Updated Sankey plot for updated ggplot2 and ggforce versions ([`7270e32`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7270e3201ef1db013c76c4bc996c008cb9f3ea07))

* fix(DESCRIPTION): Setting explicit versions for depends ggplot2, ggforce to fix plotting issue ([`e09371f`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e09371fc1c72357658a85ccacc70a2b51bc61061))

* fix(DESCRIPTION): Relaxed version spec for depends ([`2c8b69a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/2c8b69a8224fcb9117126595d9c2765b3ce96eb3))

* fix(DESCRIPTION): Updated dependencies in DESCRIPTION to be imports not depends ([`eedb3e3`](https://github.com/NIDAP-Community/DSPWorkflow/commit/eedb3e319f4a86d25b7d1e37fbdc9b8aeeed5b02))

* fix: install bioconductor packages

see https://bioinformatics.stackexchange.com/a/3375 ([`f484033`](https://github.com/NIDAP-Community/DSPWorkflow/commit/f4840334e3f5ba02ea6ff0106df5ad2a5e329679))

* fix(kidney integration test): Updated kidney test markdown for testing new filtering features ([`9fd601f`](https://github.com/NIDAP-Community/DSPWorkflow/commit/9fd601ffe6da453d51c4b1b8d4b7481fca0264df))

* fix(DEG): format change ([`6e4482a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/6e4482aee8ecfb993e240f66b172f3de5912d7db))

* fix(DEG): New config for yml file ([`65f7614`](https://github.com/NIDAP-Community/DSPWorkflow/commit/65f7614e175c1af866404e5199e684152c607b2a))

* fix(DEG): changed error checking code ([`eeeecd1`](https://github.com/NIDAP-Community/DSPWorkflow/commit/eeeecd152d08de400b5262787320cba78fea8e44))

### Unknown

* Merge pull request #139 from NIDAP-Community/dev

Testing Continuous Deployment to NIDAP ([`5d5d914`](https://github.com/NIDAP-Community/DSPWorkflow/commit/5d5d9147406c0df9f54c4a08c5b0970ad3ad5427))

* Merge pull request #138 from NIDAP-Community/update_cd

feat: CI/CD and Conda Recipe ([`a675d0b`](https://github.com/NIDAP-Community/DSPWorkflow/commit/a675d0bdde26d5d201b5dc62fe161f5dd76a9b8f))

* Merge pull request #137 from NIDAP-Community/QC_flag_report_feature

Qc flag report feature ([`046f5e6`](https://github.com/NIDAP-Community/DSPWorkflow/commit/046f5e68101681546748a56c0b6a0ab3c5b1eec4))

* Update to Kidney Integration Test ([`33b76b1`](https://github.com/NIDAP-Community/DSPWorkflow/commit/33b76b1fa7961e68ebaa154d1daf688dbfa8ba9a))

* Merge branch &#39;dev&#39; of https://github.com/NIDAP-Community/DSPWorkflow into dev

Conflicts:
	vignettes/Integration_Test_Kidney.Rmd ([`3fab7b1`](https://github.com/NIDAP-Community/DSPWorkflow/commit/3fab7b18af7c646d6fe0f67129ed93ca3c1cb899))

* Kidney Integration test: Update for QC parameters ([`b880f9e`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b880f9e0ad1a664b70619e518b4b50fd6105de7c))

* Merge pull request #136 from NIDAP-Community/defix_830

Defix 830 ([`25cd950`](https://github.com/NIDAP-Community/DSPWorkflow/commit/25cd9505a34513145bfe78336349f1c623ef4b02))

* Merge branch &#39;dev&#39; into defix_830

Signed-off-by: Ned Cauley &lt;escauley@users.noreply.github.com&gt; ([`5bebe06`](https://github.com/NIDAP-Community/DSPWorkflow/commit/5bebe0655b80c50c631ee6df3692797c6bb8fd64))

* Merge pull request #135 from NIDAP-Community/filter_segment_selection

Filter segment selection ([`62140eb`](https://github.com/NIDAP-Community/DSPWorkflow/commit/62140ebe1549988a157c68adaf0c3077ced4e6a5))

* Merge branch &#39;dev&#39; into filter_segment_selection

Signed-off-by: Ned Cauley &lt;escauley@users.noreply.github.com&gt; ([`df9ac61`](https://github.com/NIDAP-Community/DSPWorkflow/commit/df9ac61d904ed9f6ce5e7a7fea114ae69cc31c3f))

* Merge pull request #134 from NIDAP-Community/fix_sankey

Fix sankey ([`b96dba8`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b96dba88f7cfdf7e0a9a5118bbc21f2f518913a0))

* Merge pull request #133 from NIDAP-Community/fix_dependencies

Fix dependencies ([`b1719d0`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b1719d0b807e77213c79b122f12d7990d4875a25))

* Merge branch &#39;fix_dependencies&#39; of https://github.com/NIDAP-Community/DSPWorkflow into fix_dependencies ([`31113a7`](https://github.com/NIDAP-Community/DSPWorkflow/commit/31113a7f8dc1be19f3a371082fdfbc77c35bffdd))

* fix(DESCRIPTION) ([`191badc`](https://github.com/NIDAP-Community/DSPWorkflow/commit/191badc63aa2ff015f2366caf1a270e6cc46fdb7))

* Merge pull request #132 from NIDAP-Community/dev

Dev ([`f9deb63`](https://github.com/NIDAP-Community/DSPWorkflow/commit/f9deb637e09ab7f4b4c9db14aa92f096b8971a32))

* Merge pull request #125 from NIDAP-Community/bioc

fix: install bioconductor packages ([`d013780`](https://github.com/NIDAP-Community/DSPWorkflow/commit/d013780068fe8ada8904883881d35ef51cae4e18))

* Merge pull request #130 from NIDAP-Community/dev

Dev ([`9ea4353`](https://github.com/NIDAP-Community/DSPWorkflow/commit/9ea4353802aa8cebb61df1194f047473b5d79dd5))

* Merge pull request #129 from NIDAP-Community/fix_dependencies

fix(DESCRIPTION) ([`4adf523`](https://github.com/NIDAP-Community/DSPWorkflow/commit/4adf5239ab73cecf9a7daf510741f2d2ebddcf9d))

* fix(initialization):Added slide name to segmentID ([`2322b1e`](https://github.com/NIDAP-Community/DSPWorkflow/commit/2322b1e4cae12126fbb75bbf2bbb667c95976f34))

* Merge pull request #123 from NIDAP-Community/linear_model_de

feat(initialization):Added segmentID creation ([`8a3453a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/8a3453ae47a599f6f68d27debb994493eaf3d035))

* feat(initialization):Added segmentID creation ([`b613d7d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b613d7d8cb48a719c0081fc18b24565a829d7bae))

* Merge pull request #122 from NIDAP-Community/dev

Dev ([`0830ab9`](https://github.com/NIDAP-Community/DSPWorkflow/commit/0830ab9bba8b1d7dd7d838a2701e0358ace97ea9))

* Merge pull request #121 from NIDAP-Community/linear_model_de

fix(doc):Updated version number ([`c65bc5b`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c65bc5bf672acee4a246f3b9ce4d1b6d8b736822))

* fix(doc):Updated version number ([`4ad6f29`](https://github.com/NIDAP-Community/DSPWorkflow/commit/4ad6f29b560516c53b69fdc771eb9e12e2e92296))

* Merge pull request #120 from NIDAP-Community/dev

Dev ([`c2337f9`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c2337f9f2a982dcd720d07363950a75403cc1997))

* Merge pull request #119 from NIDAP-Community/linear_model_de

Added linear model (no random effect) in DEG analysis ([`ed70388`](https://github.com/NIDAP-Community/DSPWorkflow/commit/ed70388469bbe6d8e9bf3ba40d1acf7540db0c0a))

* Merge pull request #117 from NIDAP-Community/dev

Update description to 1.1.1 ([`2691689`](https://github.com/NIDAP-Community/DSPWorkflow/commit/2691689c88b92516a0fccc0843a04f0705d7f6a4))

* Merge pull request #116 from NIDAP-Community/update_description

fix (DESCRIPTION): Updated description to version 1.1.1 ([`7c38039`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7c380398b8f15a027cd9a941f70da1c2de0b3b39))

* fix (DESCRIPTION): Updated description to version 1.1.1 ([`33f341d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/33f341dc197decbecf54bebb5f6e1a6fa72335c0))

* Merge pull request #115 from NIDAP-Community/dev

Dev ([`a8cebab`](https://github.com/NIDAP-Community/DSPWorkflow/commit/a8cebab2cc30d447a2e409c53ef79d15b980f89c))

* Merge pull request #114 from NIDAP-Community/sankey_update

Updated filtering with new Sankey parameter ([`b5675af`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b5675af6e902abdbe5f6db12e6f0c2804ddd4919))

* feat (filtering): Added parameter and adjusted function to exlude slide from Sankey ([`f082802`](https://github.com/NIDAP-Community/DSPWorkflow/commit/f0828020c84bb5a76ef9d88743b6da238bba4c4a))

* Merge pull request #113 from NIDAP-Community/sankey_update

Added parameter for excluding slide from sankey ([`20fb59f`](https://github.com/NIDAP-Community/DSPWorkflow/commit/20fb59f1cc0424a712aa027ecf2ec98994f1d1ec))

* feat (study design): Added parameter and adjusted function for optionally excluding slide from Sankey plot ([`7a4906b`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7a4906b9156bec1d4d6e6178eac904760b52c143))

* Merge branch &#39;CPTR_dataset&#39; into dev

Signed-off-by: Ned Cauley &lt;escauley@users.noreply.github.com&gt; ([`17670b3`](https://github.com/NIDAP-Community/DSPWorkflow/commit/17670b30b2eea1a709f9c2f3a8abb4588a5f3d94))

* Merge pull request #110 from NIDAP-Community/filtering

Fixes for filtering: genes of interest table print, parameters for segment gene detection and study gene detection, Sankey plot update ([`424456d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/424456d9a1c4839459b9334cd09bd2bb820bfe9b))

* fix (test-filtering): Updated test and helper for new Filtering parameters ([`c54fff1`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c54fff18fec4caf3ed87a679f35cb94452a0c87c))

* fix (filtering): Sankey plot adjusted to match Study Design ([`4cb09be`](https://github.com/NIDAP-Community/DSPWorkflow/commit/4cb09be492b110aadffa263185aac8ff2156557a))

* Added missing parameters for cutoffs for gene detetion per segment and per whole study, restructured script for these new parameters ([`a072c4c`](https://github.com/NIDAP-Community/DSPWorkflow/commit/a072c4cd50cd9e05219d03dd2d6c8c4585a0d9f4))

* fix (filtering): Added defaults for parameters, cleaned up error messages and variable names, and fixed print for goi table ([`e91506a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e91506a08c0578c3df162d10dae3297f8e99db00))

* Merge branch &#39;main&#39; into CPTR_dataset ([`1593667`](https://github.com/NIDAP-Community/DSPWorkflow/commit/159366754588ba41821861ff85270a29fd14a70c))

* test (Kidney integration): Changed fixture creation back to FALSE, should not default to fixture creation ([`ad16183`](https://github.com/NIDAP-Community/DSPWorkflow/commit/ad161832aaeea8906275b460caa92e7c02f3acdb))

* test (CPTR Integration): Added goi list for DEG analysis and fixed variable names so that all units run ([`4005391`](https://github.com/NIDAP-Community/DSPWorkflow/commit/40053917712c9ba61fe92e48727e817ec3c31f38))

* Added GOI table printing for Filtering ([`2a7be1a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/2a7be1aeadceb63ec79d217a42895e946b4d970a))

* Started CPTR vignette and added fixtures ([`0abf579`](https://github.com/NIDAP-Community/DSPWorkflow/commit/0abf5795cd056cf2733d08a8a25cbf9604d28f72))

* Merge pull request #109 from NIDAP-Community/dev

Dev ([`3b8b779`](https://github.com/NIDAP-Community/DSPWorkflow/commit/3b8b77941ad63cc15a50e1e3f01fcdcdf257ba14))

* Merge pull request #108 from NIDAP-Community/DESCRIPTION-update

Description update ([`be954aa`](https://github.com/NIDAP-Community/DSPWorkflow/commit/be954aa4136b7b337760c005d15fd5726914515f))

* Update DESCRIPTION

Signed-off-by: Ned Cauley &lt;escauley@users.noreply.github.com&gt; ([`e93caa7`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e93caa7a18f2acb06ead32fcb9f6057b07854ac0))

* Merge pull request #106 from NIDAP-Community/dev

Dev ([`a221eda`](https://github.com/NIDAP-Community/DSPWorkflow/commit/a221eda8c1b4bcbd7804247822ffa0f840a068ce))

* Merge pull request #105 from NIDAP-Community/DEG_fix

Changed default FDR method to BH ([`677d59e`](https://github.com/NIDAP-Community/DSPWorkflow/commit/677d59e5246cede043ae5b827e50eefe5083248a))

* Changed default FDR method to BH ([`899e3f6`](https://github.com/NIDAP-Community/DSPWorkflow/commit/899e3f6f68804d704c55ab5989e7aa0565c68545))

* Merge pull request #104 from NIDAP-Community/dev

Dev ([`1d470af`](https://github.com/NIDAP-Community/DSPWorkflow/commit/1d470afa88009d56bd1c94d179fe437f04b83cdc))

* Merge pull request #103 from NIDAP-Community/parameter_update

Added knit integration test markdowns ([`5bc88da`](https://github.com/NIDAP-Community/DSPWorkflow/commit/5bc88da8a2e5923aca580de6dd2840e5635ecfe9))

* Added knit integration test markdowns ([`046c413`](https://github.com/NIDAP-Community/DSPWorkflow/commit/046c4131967bf35789754c3f98cf49f1e6c34008))

* Merge pull request #102 from NIDAP-Community/dev

Dev ([`c7230f2`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c7230f212c53f1105417b1ad208fd3decec6c51d))

* Merge pull request #101 from NIDAP-Community/parameter_update

Fixed normalization test ([`35698a9`](https://github.com/NIDAP-Community/DSPWorkflow/commit/35698a9a424d6dc040ba282bd7ab8f09e2e1bdba))

* Fixed normalization test ([`357227a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/357227af4df6f6c9ed711c52216b9813740fb3fb))

* Merge pull request #99 from NIDAP-Community/parameter_update

Parameter update ([`d22d061`](https://github.com/NIDAP-Community/DSPWorkflow/commit/d22d0616aa6582a485e7fd8e42e925acf4cdb42a))

* Updates to integration markdown tests for new study design parameters and normalization selection ([`5d37904`](https://github.com/NIDAP-Community/DSPWorkflow/commit/5d37904d6795447243abc6c5fdbd8a8e031fbda6))

* Whole pipeline overview and modifications for paramater changes and multi-file normalization ([`168bc90`](https://github.com/NIDAP-Community/DSPWorkflow/commit/168bc901540ec43f5aa9065dacd42cb0e1bb5eb0))

* Added additional boxplot to normalization test ([`585406d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/585406da50f9174014b8d2dafc466463cb2aa8bc))

* Merge pull request #96 from NIDAP-Community/studydesign

Studydesign ([`7de418b`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7de418ba735cf1a3d5a4c7c8f4a9e498e603e9b3))

* Added parameters for annotation fields, adjusted slide name to slide_name, added normalization plots ([`f93480d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/f93480d103ddac57e393a0d98cb1e4e87f51184b))

* Added parameters for required annotation field names ([`66c1dfb`](https://github.com/NIDAP-Community/DSPWorkflow/commit/66c1dfbe07eb4d422894a83e18d8c1fdb4ade809))

* Merge pull request #94 from NIDAP-Community/diffExpr_fix

Diff expr fix ([`7d398d1`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7d398d1e2029f9b06139340979651ad6e474f9d0))

* Add comments ([`317eda0`](https://github.com/NIDAP-Community/DSPWorkflow/commit/317eda00d8dcff7bd3ec83117eff8c24216158c4))

* Merge pull request #95 from NIDAP-Community/spatDeconv

update test and functions for spatDeconv, added published and relevant profile matrices to fixtures, expected image outputs to fixtures. ([`26907c8`](https://github.com/NIDAP-Community/DSPWorkflow/commit/26907c8a4484db295f557380e2dc3488d7c2540c))

* update test and functions ([`e68cd6f`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e68cd6fe275dbb9c8601038f1e8d04a76004693e))

* Remove extra file for diff exp testing ([`4058e2e`](https://github.com/NIDAP-Community/DSPWorkflow/commit/4058e2edeb1339ec3a009a50310b659eedeb2d1c))

* Added more error messages in case region or group is missing ([`8cbf197`](https://github.com/NIDAP-Community/DSPWorkflow/commit/8cbf1972956479d39dbb42ea36cc1b41842dcef8))

* Merge pull request #91 from NIDAP-Community/diffExpr

Diff expr ([`994635d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/994635dcc09be4bb383e83605463bc952efd5596))

* changed Description file

Merge branch &#39;diffExpr&#39; of https://github.com/NIDAP-Community/DSPWorkflow into diffExpr

Conflicts:
	DESCRIPTION
	R/differential_expression_analysis.R ([`47f8638`](https://github.com/NIDAP-Community/DSPWorkflow/commit/47f86388452aea153983c1da1ff46ab99770f776))

* Remove print statement ([`a5c35c3`](https://github.com/NIDAP-Community/DSPWorkflow/commit/a5c35c30ee86083db1f15b6d0b7b663ec55ed9fa))

* space ([`407f1d0`](https://github.com/NIDAP-Community/DSPWorkflow/commit/407f1d026fe7a6fba1fbf27f0e156f4c5810fc2d))

* space ([`11a1735`](https://github.com/NIDAP-Community/DSPWorkflow/commit/11a1735c557bcc1e1282e2f9b70adb432dac2cd4))

* Recommitting changes ([`624a8ff`](https://github.com/NIDAP-Community/DSPWorkflow/commit/624a8ffe01e2bb9c669faf9379c759d7597907e9))

* Merge pull request #90 from NIDAP-Community/dev

Synchronize diffExpr with dev ([`2668621`](https://github.com/NIDAP-Community/DSPWorkflow/commit/266862106abf00c801ce9f04a09dcaa833c97d22))

* Merge pull request #89 from NIDAP-Community/main

Synchronizing Dev to Main ([`7999c7e`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7999c7e791fa76f6efbcfddf8ea66949257017df))

* Added scientific notation and remove messages ([`4b352a1`](https://github.com/NIDAP-Community/DSPWorkflow/commit/4b352a1724a88ba5566f1d34ad4fa207e75453ca))

* Update DESCRIPTION

Signed-off-by: Ned Cauley &lt;escauley@users.noreply.github.com&gt; ([`eb070e9`](https://github.com/NIDAP-Community/DSPWorkflow/commit/eb070e9edda74377a0270c5d67154964e76a4247))

* Merge pull request #87 from NIDAP-Community/dev

Dev ([`cff2fee`](https://github.com/NIDAP-Community/DSPWorkflow/commit/cff2fee45182d56f7200697cc5f4389946d62dfd))

* Update DESCRIPTION

Signed-off-by: Ned Cauley &lt;escauley@users.noreply.github.com&gt; ([`ac60309`](https://github.com/NIDAP-Community/DSPWorkflow/commit/ac60309068a5ec5797376a522f77b2ca956b0cb8))

* Updated nanostringnctools to 1.4.0 ([`7efef6f`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7efef6fc2ad99b3842d11a9cbac28f78703b1bcb))

* Updated DESCRIPTION to match resolved NIDAP environment DSP_pkg_testing ([`bd11104`](https://github.com/NIDAP-Community/DSPWorkflow/commit/bd1110448ae4e873a491f22350103cf1a59a4e1d))

* Merge pull request #83 from NIDAP-Community/dev

Updates for spatial decon vignette and version for NanostringNCTools ([`65446a4`](https://github.com/NIDAP-Community/DSPWorkflow/commit/65446a48618fff31567c11b9b2714d30e71ae86c))

* Updates for spatial decon vignette and version for NanostringNCTools ([`a1a21f5`](https://github.com/NIDAP-Community/DSPWorkflow/commit/a1a21f57f2353476ae94302b3d4889f472900e19))

* Merge pull request #82 from NIDAP-Community/dev

Dev ([`fecb39b`](https://github.com/NIDAP-Community/DSPWorkflow/commit/fecb39bd2ec1d238096280411b0275390d9e2407))

* Comma typo in DESCRIPTION ([`fcfdbec`](https://github.com/NIDAP-Community/DSPWorkflow/commit/fcfdbec72df382af72486ec7528866568f442c48))

* Update for R and Biobase version specifications ([`184b338`](https://github.com/NIDAP-Community/DSPWorkflow/commit/184b338f679b4cf49a56327b0c982bd943b635f2))

* Update gitflow-R-action.yml

Signed-off-by: Ned Cauley &lt;escauley@users.noreply.github.com&gt; ([`61981de`](https://github.com/NIDAP-Community/DSPWorkflow/commit/61981de5561106a3c048ba83cacdfd70f3403f36))

* Update gitflow-R-action.yml

Signed-off-by: Ned Cauley &lt;escauley@users.noreply.github.com&gt; ([`3e95fa1`](https://github.com/NIDAP-Community/DSPWorkflow/commit/3e95fa1c77a03063644e4439e9568314a9254006))

* Asjusted version of gtable per build error on git action ([`14e3d89`](https://github.com/NIDAP-Community/DSPWorkflow/commit/14e3d89bde4a57fe95ebf67c93003bad7dd5b3a2))

* Corrected = to == ([`58f37f8`](https://github.com/NIDAP-Community/DSPWorkflow/commit/58f37f842d12517b42df37c52e8cdc32f629ad81))

* Merge pull request #75 from NIDAP-Community/heatmap

Update heatmap.R ([`3b395e3`](https://github.com/NIDAP-Community/DSPWorkflow/commit/3b395e3d87cc2d26cf3f3dfd09e5ae0956ccee06))

* Updates for resolving conda package build issues ([`ac570cd`](https://github.com/NIDAP-Community/DSPWorkflow/commit/ac570cd3a54302b81f5ccff2c5c78a48c42a9bc0))

* Update heatmap.R ([`797929f`](https://github.com/NIDAP-Community/DSPWorkflow/commit/797929f419af5316b143dd904a915b29067fb9a5))

* Update DESCRIPTION

Signed-off-by: Ned Cauley &lt;escauley@users.noreply.github.com&gt; ([`6a33e84`](https://github.com/NIDAP-Community/DSPWorkflow/commit/6a33e84fa28a7da4c877c66403632df63d62fbc0))

* Update DESCRIPTION

Signed-off-by: Ned Cauley &lt;escauley@users.noreply.github.com&gt; ([`7c6b4d2`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7c6b4d200c9e367d7aa463998ee770c86e7cd564))

* Merge pull request #74 from NIDAP-Community/dev

Updated for ggforce version and redocument ([`b5c8a12`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b5c8a12ed02241fe915120c788eb666db1e5a841))

* Updated for ggforce version and redocument ([`ff2a1e4`](https://github.com/NIDAP-Community/DSPWorkflow/commit/ff2a1e49545dd0a72a7b3f4cac2be8640267c22b))

* Merge pull request #72 from NIDAP-Community/dev

Dev ([`33108a4`](https://github.com/NIDAP-Community/DSPWorkflow/commit/33108a4d491fd7a94a0fe64e2e24617ece7dddef))

* Merge pull request #73 from NIDAP-Community/heatmap

changed internal calc.cv to .calcCv in Heatmap function ([`7b23f08`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7b23f080b7907c0ab84eed6b99d5e9a16040f145))

* Update heatmap.R ([`2391b81`](https://github.com/NIDAP-Community/DSPWorkflow/commit/2391b8191fa0b11579a9afa59e5e694e723d285f))

* Merge branch &#39;dev&#39; of https://github.com/NIDAP-Community/DSPWorkflow into dev ([`e2b8449`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e2b84495ff0347f5bea58fc5ff9e13470eaa182d))

* Added ComplexHeatmap import ([`c1c5437`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c1c5437db812ad676358eb49ab9fcbcc9a1fc409))

* Merge pull request #71 from NIDAP-Community/dev

Dev ([`6873033`](https://github.com/NIDAP-Community/DSPWorkflow/commit/6873033ceaeae1f2c18b98c292a016504e97a874))

* Merge pull request #70 from NIDAP-Community/spatDeconv2

modified spatDeconv helper ([`13a9ebc`](https://github.com/NIDAP-Community/DSPWorkflow/commit/13a9ebc272a5a1bb8b856afeaec6e373fa59dd5a))

* modified spatDeconv helper ([`b4261aa`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b4261aafc8163677a2b8fdc75c6a4dfa16ff8f77))

* Merge pull request #69 from NIDAP-Community/diffexpr_fix

ttheme_default ([`ee4d318`](https://github.com/NIDAP-Community/DSPWorkflow/commit/ee4d3182b0e74f85c7784eb27fa641b1d4883ff1))

* ttheme_default ([`cae3ff0`](https://github.com/NIDAP-Community/DSPWorkflow/commit/cae3ff0a2e6e10af6e28efabbe90a1a99dda9f61))

* Merge pull request #67 from NIDAP-Community/qcProc

Qc proc ([`a88347f`](https://github.com/NIDAP-Community/DSPWorkflow/commit/a88347fdde24d43692eedc3c359c1b1fded11942))

* add output table in return description ([`f302908`](https://github.com/NIDAP-Community/DSPWorkflow/commit/f302908873a59e82c5fa0eba8ebed7a47a858a52))

* Update gitflow-R-action.yml

Add new docker image

Signed-off-by: Ned Cauley &lt;escauley@users.noreply.github.com&gt; ([`016d89b`](https://github.com/NIDAP-Community/DSPWorkflow/commit/016d89b131808c805f0906140549fb3a211af976))

* qcProc clean warnings 1 ([`694fb61`](https://github.com/NIDAP-Community/DSPWorkflow/commit/694fb6155263c3232673430a460ba577f7c68b1a))

* Merge pull request #65 from NIDAP-Community/Update_Github_Action

Update gitflow-R-action.yml ([`fb2a804`](https://github.com/NIDAP-Community/DSPWorkflow/commit/fb2a8041029952979e845bd49176d98acccf29f0))

* Update gitflow-R-action.yml

Updated the Docker image version to use in action

Signed-off-by: ruiheesi &lt;107956586+ruiheesi@users.noreply.github.com&gt; ([`3a7a118`](https://github.com/NIDAP-Community/DSPWorkflow/commit/3a7a1184bb84c4425d57f0cfecd89ec925561871))

* Merge pull request #64 from NIDAP-Community/GeoMxNorm

Updated for lowercamalcase ([`00d2098`](https://github.com/NIDAP-Community/DSPWorkflow/commit/00d209891b5edce3db7dbde96c5c19f1c42df560))

* Merge pull request #63 from NIDAP-Community/Filtering

Updated for lowercamalcase ([`031e94e`](https://github.com/NIDAP-Community/DSPWorkflow/commit/031e94edbeb5d089e3bf1a66476e0f4267607ec7))

* Updated for lowercamalcase ([`5ce7711`](https://github.com/NIDAP-Community/DSPWorkflow/commit/5ce7711c763f1996dc6656aa16547cda92056aac))

* Updated for lowercamalcase ([`d932d44`](https://github.com/NIDAP-Community/DSPWorkflow/commit/d932d447568f0b3214232aef7c6a6e58f052de43))

* Added ngeoMean function import ([`c223f08`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c223f08a2d8a6569af25160be8daf5e3acf8a9ff))

* Updated library for spatial decon and rewrote NAMESPACE ([`93ed521`](https://github.com/NIDAP-Community/DSPWorkflow/commit/93ed52141133536aac06227c1ca4cd80790a6219))

* Merge branch &#39;dev&#39; of https://github.com/NIDAP-Community/DSPWorkflow into dev ([`937eef9`](https://github.com/NIDAP-Community/DSPWorkflow/commit/937eef9a0fe022403228e564d2316907cf6c094f))

* Added complex heatmap package and updated NAMESPACE ([`2def830`](https://github.com/NIDAP-Community/DSPWorkflow/commit/2def830d43e5338932a2c0044e8ec23595f29a17))

* Merge pull request #59 from NIDAP-Community/diffExpr

Diff expr ([`d1ef2fa`](https://github.com/NIDAP-Community/DSPWorkflow/commit/d1ef2fac09eba05e4734ae937eb7c1aa4ea8e41f))

* Fixed merge conflicts for diff exp and dev ([`a787581`](https://github.com/NIDAP-Community/DSPWorkflow/commit/a78758110a1f8f7c67b0239c894a1f3cd3198184))

* Added skip on ci for NSCLC snapshot ([`92ac7b0`](https://github.com/NIDAP-Community/DSPWorkflow/commit/92ac7b036ba58236ac40a876a325cc63c658db36))

* Added skip on ci function for snapshot testing ([`f945185`](https://github.com/NIDAP-Community/DSPWorkflow/commit/f94518526fbeebcd9fc89ff3ed2183cf3eb60d50))

* testing skipping snapshot testing on github ci ([`278529d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/278529df670d5b821c7fec152264142772fcac43))

* fixed path on snap files ([`228786d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/228786d69ba2117abae207145f0ebd47d2021dc1))

* Merge pull request #55 from NIDAP-Community/spatialDeconvolution

Spatial deconvolution ([`7fe5fc3`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7fe5fc388d1ce9bcf08fc7535fc50c598f2198ed))

* Merge branch &#39;dev&#39; into spatialDeconvolution

Signed-off-by: Ned Cauley &lt;escauley@users.noreply.github.com&gt; ([`0b140de`](https://github.com/NIDAP-Community/DSPWorkflow/commit/0b140de20141e4452221c81a8b81df8cf5058220))

* Merge pull request #40 from NIDAP-Community/violinPlot

Violin plot ([`76e75a4`](https://github.com/NIDAP-Community/DSPWorkflow/commit/76e75a416b6fe7da7e7619bc5997a95db3225139))

* Merge branch &#39;dev&#39; into violinPlot

Signed-off-by: Ned Cauley &lt;escauley@users.noreply.github.com&gt; ([`31116fd`](https://github.com/NIDAP-Community/DSPWorkflow/commit/31116fd4e0ece3ea27e54ced96122ded8a4ed7e7))

* Merge branch &#39;dev&#39; of https://github.com/NIDAP-Community/DSPWorkflow into dev ([`589c82d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/589c82d6c359b9be7fefeedbcac3ce15148b9a05))

* Updated fixtures for NSCLC test dataet and other cleaned up old fixtures ([`7c711af`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7c711af713df9f6e614f948c7eb75dbcd014ec7b))

* Merge pull request #54 from NIDAP-Community/Filtering

Filtering ([`128cf85`](https://github.com/NIDAP-Community/DSPWorkflow/commit/128cf85708bdd8bfd895353e37d45d0d108e2307))

* Merge branch &#39;dev&#39; into Filtering

Signed-off-by: Ned Cauley &lt;escauley@users.noreply.github.com&gt; ([`99f2ac1`](https://github.com/NIDAP-Community/DSPWorkflow/commit/99f2ac1e98edec33bd8a05f3596e2e2bf1114713))

* NSCLC fixes for Filtering ([`8b7d22e`](https://github.com/NIDAP-Community/DSPWorkflow/commit/8b7d22efd6983362992a1b48288151d7416d9bd8))

* Updates for NSCLC filtering ([`5e3b904`](https://github.com/NIDAP-Community/DSPWorkflow/commit/5e3b9043f72f91c2a1c776959bee675b8f285c1e))

* Merge branch &#39;dev&#39; into Filtering

Signed-off-by: Ned Cauley &lt;escauley@users.noreply.github.com&gt; ([`2afd535`](https://github.com/NIDAP-Community/DSPWorkflow/commit/2afd535c0708226be0d6fc28fbe531a1f42de4d5))

* Updated diff exp helper for snap folder path ([`343ecaf`](https://github.com/NIDAP-Community/DSPWorkflow/commit/343ecafa3cee76062c398ede349ace418781cd7f))

* Added check for max num of cores available ([`efd67a3`](https://github.com/NIDAP-Community/DSPWorkflow/commit/efd67a35a00950bad10f29dc9c819d5d2e7afeee))

* Added placeholder files in downloaded fixtures folders ([`f5b0c42`](https://github.com/NIDAP-Community/DSPWorkflow/commit/f5b0c42b308d284d03e56fce552d077a6025883c))

* Error checking for dcc download, updates for test dataset parameters ([`95c2294`](https://github.com/NIDAP-Community/DSPWorkflow/commit/95c22947e880463f5f7b1d2de1e3fbfa1f22b4cd))

* Merge branch &#39;dev&#39; of https://github.com/NIDAP-Community/DSPWorkflow into dev ([`2338d9a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/2338d9ad75243d88b8335de3875bf36dbd64c259))

* Updates to description file, mouse int test ([`7b2e447`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7b2e447dad832942de04aa0472e5f87d79a1cf42))

* Merge pull request #48 from NIDAP-Community/DimReduct

fix aes inheritance for add.points ([`f825f74`](https://github.com/NIDAP-Community/DSPWorkflow/commit/f825f749474cdbe64b0dd950c32b3ea3c9b996a1))

* fix aes inheritance for add.points ([`037f8aa`](https://github.com/NIDAP-Community/DSPWorkflow/commit/037f8aad1e71844fc3bbbb4b1eadf8e7b2a6b066))

* new snapshots for DEG test ([`a9a883a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/a9a883a478cbb76c1ee5fdbafa8205ea3d5c70d7))

* Merge branch &#39;diffExpr&#39; of https://github.com/NIDAP-Community/DSPWorkflow into diffExpr ([`feb642d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/feb642d46ebb1f6b531cb47334d324a11d394635))

* changed DEG testing to create temp figures ([`bf75a32`](https://github.com/NIDAP-Community/DSPWorkflow/commit/bf75a326759f6b7b28b13936a7dec999f40a15e4))

* Merge branch &#39;dev&#39; into Filtering

Signed-off-by: ChadAHighfill &lt;69129073+ChadAHighfill@users.noreply.github.com&gt; ([`7ccb6e2`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7ccb6e206336ca8f0f039ecc09bbad01947c65e2))

* Updated ([`5f1a430`](https://github.com/NIDAP-Community/DSPWorkflow/commit/5f1a4303dc3807f11104b8684f02d12617afbd36))

* Updated ([`9083b9a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/9083b9a13bc0e86b708ae9fff8a1ba63f7ebfc21))

* Merge branch &#39;dev&#39; into heatmap

Signed-off-by: Difei Wang &lt;49001003+wangdi2016@users.noreply.github.com&gt; ([`4867331`](https://github.com/NIDAP-Community/DSPWorkflow/commit/4867331efcb4aba621859ad094ced9f03b6ea090))

* Change heatmap to ComplexHeatmap ([`a20f345`](https://github.com/NIDAP-Community/DSPWorkflow/commit/a20f3457ebaa96f57e2b3c08f8bfbd47806d8d93))

* Merge branch &#39;heatmap&#39; of https://github.com/NIDAP-Community/DSPWorkflow into heatmap ([`c8698bd`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c8698bdfd56eb2fb57c8bce6983ffccdcc6f941d))

* Updates to integration markdowns ([`3679d67`](https://github.com/NIDAP-Community/DSPWorkflow/commit/3679d675862418a01718f93aa5c1334cc263728a))

* update library of spatial deconv ([`65cd48c`](https://github.com/NIDAP-Community/DSPWorkflow/commit/65cd48c6a08d166775ba44867e7ff99e0e425b4e))

* Merge branch &#39;violinPlot&#39; of https://github.com/NIDAP-Community/DSPWorkflow into violinPlot

commit changes before merging ([`e376b2e`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e376b2e9db6254c487748a0c456192270c5f534d))

* test commit for spatial decon branch ([`8531469`](https://github.com/NIDAP-Community/DSPWorkflow/commit/85314697dfd4884245e935bf4b5d1363455814c0))

* test commit for heatmap branch ([`1282ec8`](https://github.com/NIDAP-Community/DSPWorkflow/commit/1282ec80acf0bf29e2b052b9b63c58f3fb6f2128))

* Updated NSCLC integration test working directory ([`ad69385`](https://github.com/NIDAP-Community/DSPWorkflow/commit/ad69385edf37d513b5397ffd12b1487ec0dc8ed6))

* update library section ([`053b6ea`](https://github.com/NIDAP-Community/DSPWorkflow/commit/053b6eabef9c69950a0b2333a3ad8f07b8817a02))

* Change to ComplexHeatmap ([`c32c808`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c32c808875095b1f6b022e67b95dc64a38d2ffa8))

* Merge branch &#39;dev&#39; of https://github.com/NIDAP-Community/DSPWorkflow into dev ([`158f578`](https://github.com/NIDAP-Community/DSPWorkflow/commit/158f57816b74e597f9abff627780d841b73b468f))

* Updating maintainer roles ([`ba45cbe`](https://github.com/NIDAP-Community/DSPWorkflow/commit/ba45cbe4bb0abed93f1971c7bc96f08c1064bfef))

* Merge pull request #39 from NIDAP-Community/update_description

Update syntax error ([`3e39d1e`](https://github.com/NIDAP-Community/DSPWorkflow/commit/3e39d1e94e93f7ec97535cfdf4035ec254c3a307))

* Update syntax error ([`72721e3`](https://github.com/NIDAP-Community/DSPWorkflow/commit/72721e31fe69331ae3b595c5362786a6791c92a0))

* Author info adjusted to one line each ([`65eb588`](https://github.com/NIDAP-Community/DSPWorkflow/commit/65eb588afc8c56fa556ec67453db43578c8a939c))

* format update for DESCRIPTION ([`71acf0a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/71acf0a63f3626e72f72e1aa404c806644e8bb9a))

* Updated formatting in DESCRIPTION and redocumented NAMESPACE ([`3a4534d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/3a4534d7dde0712d11da3327594e0336910065ed))

* Merge branch &#39;dev&#39; of https://github.com/NIDAP-Community/DSPWorkflow into dev

Conflicts:
	DESCRIPTION ([`4a0172f`](https://github.com/NIDAP-Community/DSPWorkflow/commit/4a0172f19cf129947dcbd4fd54f1331b21f29214))

* Updates to Description and deleted test files ([`143e624`](https://github.com/NIDAP-Community/DSPWorkflow/commit/143e624112181277d649d118df6581738276a713))

* Merge pull request #38 from NIDAP-Community/dev

Changes for NIDAP integration: declare Biobase ([`3803ebc`](https://github.com/NIDAP-Community/DSPWorkflow/commit/3803ebc52bbab17248434882df3974c83646ff72))

* Merge pull request #37 from NIDAP-Community/diffExpr

Rewriting NAMESPACE ([`c77f99c`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c77f99cdbd64024a1966e7145e0bbe49bb04cdf4))

* Merge branch &#39;dev&#39; into diffExpr

Signed-off-by: maggiecam &lt;maggie.cam@nih.gov&gt; ([`7591a2b`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7591a2b0e2f6ff740b0e57bdeee75c5b0a49177c))

* Make explicit call to Biobase package ([`795b82d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/795b82da4ddb70270fc2f95deb1ecaad2b908cc6))

* Rewriting NAMESPACE ([`5e82792`](https://github.com/NIDAP-Community/DSPWorkflow/commit/5e827922abea86f0f48cf6bf55658750cd97362b))

* Merge pull request #36 from NIDAP-Community/diffExpr

Added Biobase::pData and changed gtable_add_rows parameter ([`1b2eae6`](https://github.com/NIDAP-Community/DSPWorkflow/commit/1b2eae6277d6a67d6cd116c651f4412fe1ec629c))

* Added Biobase::pData and changed gtable_add_rows parameter ([`d35b828`](https://github.com/NIDAP-Community/DSPWorkflow/commit/d35b828f964896d70478bd1bd6c314e2d31181e2))

* Merge pull request #35 from NIDAP-Community/dev

Dev ([`6afdf67`](https://github.com/NIDAP-Community/DSPWorkflow/commit/6afdf674095653d1d22605b1841230ece300a49f))

* Merge branch &#39;main&#39; into dev

Signed-off-by: Ned Cauley &lt;escauley@users.noreply.github.com&gt; ([`12cd549`](https://github.com/NIDAP-Community/DSPWorkflow/commit/12cd549dc12fb70c92f36265ecea616c126e042d))

* Merge pull request #34 from NIDAP-Community/dev_corrections

Dev corrections ([`d089b81`](https://github.com/NIDAP-Community/DSPWorkflow/commit/d089b81754d1ead314358e2e7fe9aebfe17473ac))

* added formatting to test result ([`0920b2f`](https://github.com/NIDAP-Community/DSPWorkflow/commit/0920b2f543ef341038188a07fffcad7b5eefca5b))

* Removed duplicate mixedModelDE function call ([`6769922`](https://github.com/NIDAP-Community/DSPWorkflow/commit/6769922a291ca6e249eda0115a1b0baf857eafd8))

* Updates to diff exp test snap paths ([`e65cddd`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e65cdddc77d6dfb215032c8b7c77fc088a43fe1f))

* changed format for test results for DEG, ([`ad3a161`](https://github.com/NIDAP-Community/DSPWorkflow/commit/ad3a161685097493224fd75ba07df0c5bc1b9712))

* Merge branch &#39;dev_corrections&#39; of https://github.com/NIDAP-Community/DSPWorkflow into dev_corrections ([`0528e29`](https://github.com/NIDAP-Community/DSPWorkflow/commit/0528e29e98e631a42129d626ce82dfe0157a67a0))

* Corrected Kidney dcc file list and remade fixtures ([`4cc6aad`](https://github.com/NIDAP-Community/DSPWorkflow/commit/4cc6aad1b1c8ef766cd6330cfcf5dd69a74d7093))

* merge conflict ([`e3af5e8`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e3af5e8509eea63c7a0d4b3282cd1bcb030e2ed1))

* Updated NAMESPACE and reintroduced changed to diff exp for stringr ([`179ebc0`](https://github.com/NIDAP-Community/DSPWorkflow/commit/179ebc0af60a575d6451a74735c33f98f6fc4783))

* deleted old files ([`7220db8`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7220db82a08576eb9180d7a6c1d57bb27b4b8b12))

* removed rmpfr from R scripts ([`b14c792`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b14c792f1b387fb87be8ee6e5fc9826ac995e76b))

* Merge pull request #33 from NIDAP-Community/hotfix_3_28

Update DESCRIPTION and cleaned root directory ([`8ddd406`](https://github.com/NIDAP-Community/DSPWorkflow/commit/8ddd40670ff7d73d9e928c5d1ad002b8c3a7fe13))

* Update DESCRIPTION and cleaned root directory ([`b3b9ae5`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b3b9ae560084176a7386d0f39f79f3cab9723fd7))

* Update DESCRIPTION to add magrittr and Update readme to use image in vignettes ([`b0eb7f7`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b0eb7f7c8689e3863582880d48d887dbcbc69cfd))

* Merge pull request #32 from NIDAP-Community/dev

Dev ([`b30c557`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b30c557bc15e9e26333cf550fbce3e12461b7f3b))

* Merge pull request #31 from NIDAP-Community/diffExpr

Remove stringr from function - incompatible with r-4.1 ([`ad28d55`](https://github.com/NIDAP-Community/DSPWorkflow/commit/ad28d553fe351444769b809ac1f02afc09bc3901))

* Remove stringr from function - incompatible with r-4.1 ([`2755f31`](https://github.com/NIDAP-Community/DSPWorkflow/commit/2755f314e6a143c1e9544df38baa282e9ad89646))

* Merge pull request #30 from NIDAP-Community/integration_tests

Integration tests ([`7b29b5c`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7b29b5c2b70c857c77b4f2d01dc30bd3c8c4bfd8))

* Merge branch &#39;dev&#39; into integration_tests

Signed-off-by: Ned Cauley &lt;escauley@users.noreply.github.com&gt; ([`0da610c`](https://github.com/NIDAP-Community/DSPWorkflow/commit/0da610cdd26c113745a4c1f38432a71bc5b2f8a6))

* Removed extra package from violin plot ([`5180991`](https://github.com/NIDAP-Community/DSPWorkflow/commit/51809913c90cae7ae479b47b9059863b5358b749))

* Merge branch &#39;integration_tests&#39; of https://github.com/NIDAP-Community/DSPWorkflow into integration_tests ([`09c763a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/09c763adea4a54779f26953f6efedf92af524550))

* Edits for non-used packages and function names ([`d52d098`](https://github.com/NIDAP-Community/DSPWorkflow/commit/d52d098f57919897a95d4a018a2581db9f1d2e45))

* Merge pull request #29 from NIDAP-Community/dev

Dev ([`e26a21c`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e26a21cc6f0bcd699e35b9746f94259e9de626ed))

* Update study_design.R

Signed-off-by: Ned Cauley &lt;escauley@users.noreply.github.com&gt; ([`6193584`](https://github.com/NIDAP-Community/DSPWorkflow/commit/61935848cc17302e12f031ba15fb302016ad624d))

* Update NAMESPACE

Signed-off-by: Ned Cauley &lt;escauley@users.noreply.github.com&gt; ([`91b50f0`](https://github.com/NIDAP-Community/DSPWorkflow/commit/91b50f06d0d931e2a62d448627637c71c8cd5473))

* Merge pull request #28 from NIDAP-Community/dev

Dev ([`2f58092`](https://github.com/NIDAP-Community/DSPWorkflow/commit/2f58092f1e95a394590281506a0fb38100960e8d))

* Merge pull request #27 from NIDAP-Community/StudyDesign

Study design ([`2234904`](https://github.com/NIDAP-Community/DSPWorkflow/commit/22349049b67c4505ccee99608c774504f7fb51c2))

* Merge branch &#39;dev&#39; into StudyDesign

Signed-off-by: Ned Cauley &lt;escauley@users.noreply.github.com&gt; ([`1f7abb4`](https://github.com/NIDAP-Community/DSPWorkflow/commit/1f7abb413182be1e9c33c8d6c045c184d07e9b13))

* Merge pull request #26 from NIDAP-Community/integration_tests

Integration tests ([`2df4ee7`](https://github.com/NIDAP-Community/DSPWorkflow/commit/2df4ee72b1e30e18710031c24d4d1efa5498f897))

* Merge branch &#39;dev&#39; into integration_tests

Signed-off-by: Ned Cauley &lt;escauley@users.noreply.github.com&gt; ([`1da7083`](https://github.com/NIDAP-Community/DSPWorkflow/commit/1da70833688b63e6554bf0d8fd2284dc9e371da0))

* Merge pull request #25 from NIDAP-Community/Filtering

Filtering ([`9a0ec30`](https://github.com/NIDAP-Community/DSPWorkflow/commit/9a0ec30e11c8a512a8794af4307220fec447daad))

* Merge pull request #24 from NIDAP-Community/GeoMxNorm

Geo mx norm ([`d621771`](https://github.com/NIDAP-Community/DSPWorkflow/commit/d621771952554b408954f829e7387a28a4e4b111))

* Added comment ([`d2165c4`](https://github.com/NIDAP-Community/DSPWorkflow/commit/d2165c48da0a78c8427b994a37172de167bafec4))

* Updated Kidney Integration test markdown ([`d729fbf`](https://github.com/NIDAP-Community/DSPWorkflow/commit/d729fbf93cf9950d5ff404f4e6c831da6e8cb6f2))

* Updated ([`1c84f14`](https://github.com/NIDAP-Community/DSPWorkflow/commit/1c84f14a62b8d78c9023f667bd5c92dcf8f19252))

* check ([`68d67ae`](https://github.com/NIDAP-Community/DSPWorkflow/commit/68d67aec1a95b2fd2aecb1b2c7777e265ea8fce7))

* Merge pull request #23 from NIDAP-Community/diffExpr

Set parameter pairwise = TRUE for default ([`6063c86`](https://github.com/NIDAP-Community/DSPWorkflow/commit/6063c8600ac83ea3eaf42db5ae727f8565c77653))

* Set parameter pairwise = TRUE for default ([`aaadd1b`](https://github.com/NIDAP-Community/DSPWorkflow/commit/aaadd1bac71dc6a1253f5c91cf9aa1182a306f4b))

* Updated error test ([`68707ba`](https://github.com/NIDAP-Community/DSPWorkflow/commit/68707ba55b90331caaa891ffffb36d30762bfe00))

* Check ([`c1ca228`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c1ca2288b8502f650b8c2b6be862043f4575eb58))

* Check ([`984209d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/984209dbe292280bbdee6b95e100d8dd8db4c1fe))

* Check ([`cbdbfd9`](https://github.com/NIDAP-Community/DSPWorkflow/commit/cbdbfd945583a9bd16c1cdaa96c2cffe2d1f94b4))

* Initial changes to kidney integration test ([`80d7744`](https://github.com/NIDAP-Community/DSPWorkflow/commit/80d7744dc910271f2e06b2dc17db5391238f6d08))

* Merge pull request #22 from NIDAP-Community/GeoMxNorm

Geo mx norm ([`621689e`](https://github.com/NIDAP-Community/DSPWorkflow/commit/621689e721e618d1191ba804769b44e11248996c))

* Merge pull request #21 from NIDAP-Community/Filtering

Filtering ([`206a249`](https://github.com/NIDAP-Community/DSPWorkflow/commit/206a249d256f27f3d149634c3bca2a0b31d10d6b))

* Updated organization of function, test, and helper scripts ([`41fa5ee`](https://github.com/NIDAP-Community/DSPWorkflow/commit/41fa5ee1f7d9f0ded217f18466c382d5abbe6a62))

* Merge pull request #17 from NIDAP-Community/heatmap

Heatmap ([`65fb256`](https://github.com/NIDAP-Community/DSPWorkflow/commit/65fb256e6bb28347725779c28f39fde31b33cf18))

* Merge pull request #20 from NIDAP-Community/violinPlot

Violin plot ([`12c81ab`](https://github.com/NIDAP-Community/DSPWorkflow/commit/12c81ab83a27c260f6ae704237448c2c08146148))

* Clean Up ([`c3964fa`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c3964fa99b1a0884eeac7feaea93844dbacc9e4d))

* Merge branch &#39;dev&#39; into violinPlot

Signed-off-by: Ned Cauley &lt;escauley@users.noreply.github.com&gt; ([`08ef6e3`](https://github.com/NIDAP-Community/DSPWorkflow/commit/08ef6e3412be398de06ee36555247c48b04ad956))

* Merge pull request #19 from NIDAP-Community/SpatialDeconvolution

Spatial deconvolution ([`0c81890`](https://github.com/NIDAP-Community/DSPWorkflow/commit/0c8189073cac3fa0d722e4192857d346eb00f869))

* changed helper function ([`abb250c`](https://github.com/NIDAP-Community/DSPWorkflow/commit/abb250cc25351525be4b4f93ba183739b49a0976))

* change helper function ([`ceff28c`](https://github.com/NIDAP-Community/DSPWorkflow/commit/ceff28c94476d93293cf6f830207f9e0f1995655))

* Updated organization of function, test, and helper scripts ([`304424f`](https://github.com/NIDAP-Community/DSPWorkflow/commit/304424fd38a061799b2b037d596749bd53a8797b))

* Updates to integration test, new PKC for NSCLC ([`b752559`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b752559582f8e5350b1b906d57c2e55a5c6a3dca))

* Updates ([`dc9149a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/dc9149a98a5ce2cafb0c3ecba8f14d26d89b96a9))

* Clean Up ([`fd4658e`](https://github.com/NIDAP-Community/DSPWorkflow/commit/fd4658ead81fc2be9b60e5de6d28c3cbdb55ab5f))

* Clean Up ([`882f550`](https://github.com/NIDAP-Community/DSPWorkflow/commit/882f5508846b6bab8f65dbae8d4341aff1ff8b39))

* Clean Up ([`fb7b641`](https://github.com/NIDAP-Community/DSPWorkflow/commit/fb7b64103aac29388a947fa0af99e6da69d4294c))

* Merge pull request #12 from NIDAP-Community/DimReduct

Dim reduct ([`e1af0c2`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e1af0c242b670470eda180f96beb7a4c7ed557c5))

* Updates ([`3a091a1`](https://github.com/NIDAP-Community/DSPWorkflow/commit/3a091a157131b23f4b1970581b4dab70c02b0385))

* Clean Up ([`037bcad`](https://github.com/NIDAP-Community/DSPWorkflow/commit/037bcad617c48d60e4fffc51b9ae4494f3996c20))

* dimReduct cleanup 1 ([`7e34989`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7e34989976e70de47eb46f6e8f923da6bdf746e4))

* Merge pull request #10 from NIDAP-Community/QcProc

Qc proc ([`04fb8d9`](https://github.com/NIDAP-Community/DSPWorkflow/commit/04fb8d9b084f4094b30bfb4e814f7cb8ab838b04))

* qcProc cleanup 4 ([`a89fb23`](https://github.com/NIDAP-Community/DSPWorkflow/commit/a89fb23fbb00ba1d4f2d0a33925db8d484ec9fd9))

* Merge pull request #9 from NIDAP-Community/diffExpr

Differential Expression ([`68cc182`](https://github.com/NIDAP-Community/DSPWorkflow/commit/68cc182d86ced195799f81f6dc69e5f43487c722))

* Merge pull request #8 from NIDAP-Community/StudyDesign

Study design ([`7a0b592`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7a0b592672dca01a4e60452aef8fd59da75f8fa8))

* Updates ([`59ee6b4`](https://github.com/NIDAP-Community/DSPWorkflow/commit/59ee6b4fc15efcdacb810ed6824de35413489e21))

* Update README.md

small edit

Signed-off-by: maggiecam &lt;maggie.cam@nih.gov&gt; ([`3e7939b`](https://github.com/NIDAP-Community/DSPWorkflow/commit/3e7939bc2c576eedb1bc9e8adbef3d1b9cc50255))

* Update README.md

Added image

Signed-off-by: maggiecam &lt;maggie.cam@nih.gov&gt; ([`ad8d86e`](https://github.com/NIDAP-Community/DSPWorkflow/commit/ad8d86e319ce927d9fd3ed3789ba9aab5a5ff6d3))

* Update README.md

Add image

Signed-off-by: maggiecam &lt;maggie.cam@nih.gov&gt; ([`e3a363b`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e3a363bbb437c305e9385542dd9789caa2533261))

* Add files via upload

Signed-off-by: maggiecam &lt;maggie.cam@nih.gov&gt; ([`b3ecda7`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b3ecda71a41ed444e6a82e58ebdc82c8bb95cab1))

* Delete workflow_image.png

Signed-off-by: maggiecam &lt;maggie.cam@nih.gov&gt; ([`83fe725`](https://github.com/NIDAP-Community/DSPWorkflow/commit/83fe72568d38a4a6ec32b283fb6e7d0098473cf1))

* Add files via upload

Added workflow image for readme

Signed-off-by: maggiecam &lt;maggie.cam@nih.gov&gt; ([`9206949`](https://github.com/NIDAP-Community/DSPWorkflow/commit/9206949b6dee565e78dbe1f655ec9098e43afd17))

* Update README.md

Describe Workflow

Signed-off-by: maggiecam &lt;maggie.cam@nih.gov&gt; ([`7997822`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7997822b6081fb9a6ffc381d975630c5addd31b9))

* More formatting conforming with 80 character lines. ([`cfc2e1b`](https://github.com/NIDAP-Community/DSPWorkflow/commit/cfc2e1ba4541da73e56df0d23310125a888e35bf))

* correct push qcProc ([`0b025dc`](https://github.com/NIDAP-Community/DSPWorkflow/commit/0b025dcdd4e98bf19774d0bca37591a53e0db0b5))

* QcProc @title typo correction ([`7662fa5`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7662fa541ff1109cb9fe0fd9f75ade6675dfc217))

* Added dcc download functionality to study design test ([`f2c8a02`](https://github.com/NIDAP-Community/DSPWorkflow/commit/f2c8a02026e6d12f91f4a024e5a82e5336b62327))

* qcProc reformat code ([`22134bf`](https://github.com/NIDAP-Community/DSPWorkflow/commit/22134bfe8497dbd15c20e7d5981ba4c82f8b6a10))

* qcProc update check input params ([`9ce7311`](https://github.com/NIDAP-Community/DSPWorkflow/commit/9ce7311c5a625287081aa090e71ccc4a3bc5ab33))

* Merge branch &#39;violinPlot&#39; of https://github.com/NIDAP-Community/DSPWorkflow into violinPlot

violinPlot branch is ahead by 9 commits ([`458a0d5`](https://github.com/NIDAP-Community/DSPWorkflow/commit/458a0d583ebe220e7ef71735c954f6cddb778208))

* reformat violin plot ([`3cf78b0`](https://github.com/NIDAP-Community/DSPWorkflow/commit/3cf78b0aaea7396acb43bd1cdcbf269910dc2c5a))

* formatted spatialDeconv scripts ([`42594d2`](https://github.com/NIDAP-Community/DSPWorkflow/commit/42594d2115c61c7af89d7eded6ad3103f215eeca))

* dimReduct additional cleanup ([`4d4aa70`](https://github.com/NIDAP-Community/DSPWorkflow/commit/4d4aa70fc1cf50942e5e462e5b71770f9a14c072))

* qcProc cleanup 3 after review ([`1bbdb06`](https://github.com/NIDAP-Community/DSPWorkflow/commit/1bbdb06d48840d1527da16a6427ef9a61794315e))

* format helper-diffExpr ([`eaae64e`](https://github.com/NIDAP-Community/DSPWorkflow/commit/eaae64e4d24b0b5b11968189b0e1eea2f759bfeb))

* format test-diffExpr ([`f5780f7`](https://github.com/NIDAP-Community/DSPWorkflow/commit/f5780f70b7315881f7b0a40191cbb6733ba1e1d0))

* Updated expect warnings for NSCLC QC test ([`a0a8c19`](https://github.com/NIDAP-Community/DSPWorkflow/commit/a0a8c1949b9c942ecb3d7cea050ad5161b9848de))

* Update to study design helper ([`37de3a9`](https://github.com/NIDAP-Community/DSPWorkflow/commit/37de3a94e840553e9b89219113189e6d378d2808))

* QcProc cleanup 2 ([`ea7aa35`](https://github.com/NIDAP-Community/DSPWorkflow/commit/ea7aa35b90451fc3d449b68916ff3766f6e1c2ca))

* Formatting changes in diffExpr function ([`9128e63`](https://github.com/NIDAP-Community/DSPWorkflow/commit/9128e63a6447fb45712db7e564b2d12744140114))

* dimReduct cleanup after review ([`193ab25`](https://github.com/NIDAP-Community/DSPWorkflow/commit/193ab25f9c6d09b6392a64d3d3b34a4d292b2aa0))

* Merge branch &#39;DimReduct&#39; of https://github.com/NIDAP-Community/DSPWorkflow into DimReduct

merge DimReduct ([`25f4f14`](https://github.com/NIDAP-Community/DSPWorkflow/commit/25f4f14beca6eb28a019085bf3c5c523e66e969a))

* Merge branch &#39;QcProc&#39; of https://github.com/NIDAP-Community/DSPWorkflow into QcProc

merge qcproc cleanup 1 ([`b4c93ec`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b4c93ec9d7cb58fb637d16a98d784d443ba9f516))

* qcProc cleanup 1 ([`9425d49`](https://github.com/NIDAP-Community/DSPWorkflow/commit/9425d49f17b9efe449c9742ac079ad522ad6fd0e))

* Formatting changes to diffExpr helper script ([`121fc5a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/121fc5ac310d8f92a95058a549e9d83b72fc8664))

* Formattin changes to diffExpr function ([`af9de1a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/af9de1aedb1ebad44e710f177381caba1df87ae2))

* Format changes to diffExpr test file ([`c707d94`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c707d949a5ea84716692e6039bcb57137c3aed86))

* Updated Cleaned Code ([`345dd9b`](https://github.com/NIDAP-Community/DSPWorkflow/commit/345dd9b9707936454b79b4a4ee2c7143f7ec6cfd))

* formatting changes to diffExpr ([`91884f0`](https://github.com/NIDAP-Community/DSPWorkflow/commit/91884f09d8d304c22ced91acc50a9359bc50e453))

* Formatting changes on diffExpr ([`212b641`](https://github.com/NIDAP-Community/DSPWorkflow/commit/212b6419b9e87a383b8ca5a8954366b0d82fd5b1))

* Merge branch &#39;StudyDesign&#39; of https://github.com/NIDAP-Community/DSPWorkflow into StudyDesign ([`2cb8622`](https://github.com/NIDAP-Community/DSPWorkflow/commit/2cb862231166c3bd1e66b4e470c4c5c7bf2ea4e0))

* Updated study design R and test scripts according to code review feedback ([`4d7cae5`](https://github.com/NIDAP-Community/DSPWorkflow/commit/4d7cae5ad5af4c3d8ce3cddef38d128bb2c47578))

* Merge branch &#39;GeoMxNorm&#39; of https://github.com/NIDAP-Community/DSPWorkflow into GeoMxNorm ([`a7d4724`](https://github.com/NIDAP-Community/DSPWorkflow/commit/a7d4724c8dd7686731d2106ac7290a4588716ac7))

* Update Helper script for select normalized ([`d70011d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/d70011de82a18d509f2d102e47c2a0e026119a6e))

* Update Helper script for select normalized ([`377a144`](https://github.com/NIDAP-Community/DSPWorkflow/commit/377a144d01a9da458cb3c68f411ab1597a75d9c5))

* Update Helper script for select normalized ([`3709298`](https://github.com/NIDAP-Community/DSPWorkflow/commit/37092983a3dc0345aacfcab45c5f433e16b5b17e))

* Update Helper script for select normalized ([`f8ab3fc`](https://github.com/NIDAP-Community/DSPWorkflow/commit/f8ab3fccd8f6104ed6f1d68e6e2b1ecec156790b))

* Update Helper script for select normalized ([`f579700`](https://github.com/NIDAP-Community/DSPWorkflow/commit/f57970051912f40928ec372d1f7bb9bcae83c1f8))

* Update Helper script for select normalized ([`fdc432c`](https://github.com/NIDAP-Community/DSPWorkflow/commit/fdc432c03e6aad844914111d128a1a12a4e28fc6))

* Update Helper script for select normalized ([`c364144`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c364144263e1255fc7d033c8f316fe8138bd66f3))

* Update Helper script and Action file ([`7bcfa5d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7bcfa5d0458aff33f0c95a2d49d02c69ac449372))

* Update Helper script and Action file ([`2c59b63`](https://github.com/NIDAP-Community/DSPWorkflow/commit/2c59b63cafb741776eb834d83285bb31a5d8bc1b))

* Update Helper script and Action file ([`898b1fd`](https://github.com/NIDAP-Community/DSPWorkflow/commit/898b1fda4745c6a0d008668c5cba29c4ed364699))

* Update Helper script and Action file ([`4e3b06d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/4e3b06d0b867e939a6c71007bc4580e3cebfb20f))

* Update Helper script and Action file ([`7b6af2c`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7b6af2c0a58bd8e90feb2594e796a882dd483628))

* Update Helper script and Action file ([`a9e9c9a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/a9e9c9a0851ff5e7a4f49818d4cd716ffe7581db))

* Update Helper script and Action file ([`384717f`](https://github.com/NIDAP-Community/DSPWorkflow/commit/384717f8f86e21383d21116919c22bca63f0923e))

* Update Helper script and Action file ([`97f5396`](https://github.com/NIDAP-Community/DSPWorkflow/commit/97f539607cf64762c1971ea4b7cb5b86a815a9d9))

* Update Helper script and Action file ([`6956b2c`](https://github.com/NIDAP-Community/DSPWorkflow/commit/6956b2c2589e4ca309815702e2e44dd135101cfb))

* Merge branch &#39;heatmap&#39; of https://github.com/NIDAP-Community/DSPWorkflow into heatmap ([`30471ae`](https://github.com/NIDAP-Community/DSPWorkflow/commit/30471ae43b6303f2b99a1da44106cdd14edfa01f))

* Updated study design R script to style guide ([`d3d9cd3`](https://github.com/NIDAP-Community/DSPWorkflow/commit/d3d9cd3bec155158dc635a57d0838d2288d5c497))

* Updated normalized rtd helper script ([`85ff2fb`](https://github.com/NIDAP-Community/DSPWorkflow/commit/85ff2fb22076a9c8c057819f4cce1f6f8e7119e3))

* Reset current violin_plot.R to remote branch ([`c881a0c`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c881a0c25718bf59fbd07f503b06c14ae14c95af))

* Update Actions files ([`b9993ce`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b9993ce03f92ac1eb643186edf8743cf69b37046))

* dimReduct cleanup Mar4 ([`9f22565`](https://github.com/NIDAP-Community/DSPWorkflow/commit/9f22565588123c16cdf8587755fc8671d0982522))

* Cleaned Code ([`2c07675`](https://github.com/NIDAP-Community/DSPWorkflow/commit/2c07675182575a4d55d6a3948919df920cd2f0a7))

* dimReduct code cleanup ([`168fe7b`](https://github.com/NIDAP-Community/DSPWorkflow/commit/168fe7bdfbe0ca06e79d7c2de84eede4ac09ab99))

* dimReduct cleanup ([`096107f`](https://github.com/NIDAP-Community/DSPWorkflow/commit/096107f88243e01790cc7be05329fd71f7ec1c65))

* Merge pull request #7 from NIDAP-Community/StudyDesign

Study design ([`f9e9226`](https://github.com/NIDAP-Community/DSPWorkflow/commit/f9e9226d8fc91af777ed38525708412f44b274b9))

* Update to study design script ([`60522a7`](https://github.com/NIDAP-Community/DSPWorkflow/commit/60522a7647116ada2ecd533341771f1af5dbcb16))

* Cleaned Code ([`fad0b04`](https://github.com/NIDAP-Community/DSPWorkflow/commit/fad0b04f2249629a3b2e3f4c9b3d89728ab9f995))

* Changed parameter names ([`fc83a0e`](https://github.com/NIDAP-Community/DSPWorkflow/commit/fc83a0e9087c03a79acd680b94b139beff474145))

* test ([`ed8982a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/ed8982a4c7bbb05c2a09e6f599d77b27e085562a))

* Update Check_On_Commit.yml

Signed-off-by: ruiheesi &lt;107956586+ruiheesi@users.noreply.github.com&gt; ([`684d53b`](https://github.com/NIDAP-Community/DSPWorkflow/commit/684d53b7236fac838a87bfa139d4cbdc4154aa24))

* Update Check_on_Commit.sh

Signed-off-by: ruiheesi &lt;107956586+ruiheesi@users.noreply.github.com&gt; ([`603950d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/603950d70d84bd45750721c65a809383f5f72411))

* Update commit check script to look for test scripts and function scripts only ([`5022c57`](https://github.com/NIDAP-Community/DSPWorkflow/commit/5022c572eeea08f22a5f22321a258419be3c0efc))

* Update actions ([`8426bef`](https://github.com/NIDAP-Community/DSPWorkflow/commit/8426bef0e71022d937bbad7d1295329306507d14))

* Update actions ([`124689b`](https://github.com/NIDAP-Community/DSPWorkflow/commit/124689bf7f528540d567dddb715c8fd50f00870c))

* Merge branch &#39;ruiheesi-patch-1&#39; of https://github.com/NIDAP-Community/DSPWorkflow into update_action ([`b89f85d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b89f85d6dd8423c48c52be7e94e814512d1a980b))

* Update Check on Commit ([`6165741`](https://github.com/NIDAP-Community/DSPWorkflow/commit/6165741f0d9d380f2d3fdc4fafde42d658b63398))

* Update Check_On_Commit.yml

Signed-off-by: ruiheesi &lt;107956586+ruiheesi@users.noreply.github.com&gt; ([`cee97a2`](https://github.com/NIDAP-Community/DSPWorkflow/commit/cee97a2b6a18802428decb8c7687d23dc221e948))

* Merge branch &#39;main&#39; into heatmap ([`b08d4fc`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b08d4fc001fafcc17c2dd4cc27dd56153aa34302))

* test ([`f2c4d11`](https://github.com/NIDAP-Community/DSPWorkflow/commit/f2c4d1155eed7dedd5cf6acfef371d6131e56e9f))

* Test branch ([`d90e4c5`](https://github.com/NIDAP-Community/DSPWorkflow/commit/d90e4c598c2a6f8644b320dfa8d3a9de7964b4ea))

* Update the lint checker to chekc if variable are in dotted case or  lower case. Thus function name should alway produce warning as it shoudl eb lower camel. Line length limit is currently 120 ([`ef6380e`](https://github.com/NIDAP-Community/DSPWorkflow/commit/ef6380e27f85a65907a4b6db8e072d16fc25431d))

* Merge pull request #4 from NIDAP-Community/release_v0.1

Test Release v0.1 ([`217db3c`](https://github.com/NIDAP-Community/DSPWorkflow/commit/217db3cc62362afb4818351f48d2f0f9e17b5759))

* Merge pull request #3 from NIDAP-Community/dev

Testing_merge to release actions ([`3be2756`](https://github.com/NIDAP-Community/DSPWorkflow/commit/3be2756df65d436018ce9802957fba9dcc5a5f50))

* Merge pull request #2 from NIDAP-Community/feature_test

Update README.md ([`3d4e38d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/3d4e38db6f48dafd3eb17cb0e3631c13af74f406))

* Update README.md

Signed-off-by: ruiheesi &lt;107956586+ruiheesi@users.noreply.github.com&gt; ([`9a267f2`](https://github.com/NIDAP-Community/DSPWorkflow/commit/9a267f22b5134f40468f32df82e59bd59321360b))

* Minor fix ([`3c17626`](https://github.com/NIDAP-Community/DSPWorkflow/commit/3c1762642eb5091f8d701f62c8f3f5357eb6d089))

* Update github action to use docker image hosted on NIDAP-Community repo ([`4203a91`](https://github.com/NIDAP-Community/DSPWorkflow/commit/4203a91749e85140d22e1ee2c8a491cd3f1f7200))

* Merge pull request #1 from ruiheesi/main

Add GitHub CI ([`96396d9`](https://github.com/NIDAP-Community/DSPWorkflow/commit/96396d92eeff928166abe0fe33597fd279737b86))

* Update actions files and file system structure ([`b251b00`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b251b005e57b609ea2a4e5caebb2e02fb9060198))

* Merge branch &#39;NIDAP-Community:main&#39; into main ([`3025db6`](https://github.com/NIDAP-Community/DSPWorkflow/commit/3025db66c5f3170ee36f93c83fc6a63a4b2baefa))

* Adding auto-generated files ([`113cf45`](https://github.com/NIDAP-Community/DSPWorkflow/commit/113cf45aae07a6312353e2e8d31325ebb31e7fd4))

* Merge pull request #2 from ruiheesi/feature_test

Minor fix ([`0975bca`](https://github.com/NIDAP-Community/DSPWorkflow/commit/0975bcaef24651dde66e0c049d82c04ff5a59728))

* Minor fix ([`40189a9`](https://github.com/NIDAP-Community/DSPWorkflow/commit/40189a960ff67993af541c88f37a76406f9be38c))

* Test lintr ([`a1f07bc`](https://github.com/NIDAP-Community/DSPWorkflow/commit/a1f07bcd79267435083c4a67da371535c2ee153d))

* Update lintr to check style ([`7ac6064`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7ac6064914d336d5982107351112ebf7e13c9dc7))

* Test lint ([`33c0d11`](https://github.com/NIDAP-Community/DSPWorkflow/commit/33c0d11981b269e902995f8742e4a1b46ccb802e))

* Test lint ([`9fabb54`](https://github.com/NIDAP-Community/DSPWorkflow/commit/9fabb546c38520fa77ce91eac73964aeb195289d))

* Test lint ([`404560f`](https://github.com/NIDAP-Community/DSPWorkflow/commit/404560f73eca7c2828676be7040a48d54c6bff79))

* Add lint test ([`aafe8d8`](https://github.com/NIDAP-Community/DSPWorkflow/commit/aafe8d8a9480c1617e0b5bc91ae66906cdcdd37a))

* Add lint test ([`a4391d7`](https://github.com/NIDAP-Community/DSPWorkflow/commit/a4391d79a6abbdc38cb27d1de2b9dab3838fdb49))

* Test revert ([`f84bd68`](https://github.com/NIDAP-Community/DSPWorkflow/commit/f84bd6848434bf5516cc0856d3ee6a4c2a5e8079))

* revert previous changes ([`3b8b5d0`](https://github.com/NIDAP-Community/DSPWorkflow/commit/3b8b5d0358c229d527896940875e3a6f4f649a3e))

* Test multiple file changes ([`91f8d43`](https://github.com/NIDAP-Community/DSPWorkflow/commit/91f8d43c5df2685e12f0694859de5bfe57e19c4c))

* Test multiple file changes ([`560babf`](https://github.com/NIDAP-Community/DSPWorkflow/commit/560babf69753be02e7297d6eaf12fb99b0bf36af))

* Update sh file for commit check ([`5516f7f`](https://github.com/NIDAP-Community/DSPWorkflow/commit/5516f7fa9c9d86f67b2627f779a17bb92d485f9f))

* Update yaml file ([`63af9f8`](https://github.com/NIDAP-Community/DSPWorkflow/commit/63af9f80613da50e0ccef9eab26608f516cfe658))

* Update yaml file ([`d1d7e6f`](https://github.com/NIDAP-Community/DSPWorkflow/commit/d1d7e6f296c0735471279aa3f40c00a3bd4ca36d))

* Update yaml file ([`648c348`](https://github.com/NIDAP-Community/DSPWorkflow/commit/648c348e70f79798345aa2d301ee0b7959660fab))

* Update yaml file ([`a9ae803`](https://github.com/NIDAP-Community/DSPWorkflow/commit/a9ae80308fa629dd2865c4877e58225fa85c93ff))

* Update yaml file ([`d5450c1`](https://github.com/NIDAP-Community/DSPWorkflow/commit/d5450c18ba4d343f542e0108d44e7ca6b5636264))

* Update yaml file ([`5f9a5a0`](https://github.com/NIDAP-Community/DSPWorkflow/commit/5f9a5a045ad57bfab13fb32a7fa794f5255a502e))

* Update yaml file ([`2700426`](https://github.com/NIDAP-Community/DSPWorkflow/commit/2700426ae2d9d667a5383f757bfefcde47743061))

* Update yaml file ([`7c97b56`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7c97b56951ba57803296420e52e80380f7249c7a))

* Update yaml file ([`e3004c6`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e3004c61d9108d1d2912d7c953b7b598dc9044ec))

* Update yaml file ([`1454051`](https://github.com/NIDAP-Community/DSPWorkflow/commit/145405142e7b1c45f5f3089b7b13fca09836528a))

* Update yaml file ([`d877caf`](https://github.com/NIDAP-Community/DSPWorkflow/commit/d877caf28a3a4a0dc5bb11406b5fcdcf2b618fee))

* Update dockerfile for plain and conda environment, update yaml file to use plain R contianers ([`b272e6c`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b272e6c293ed0c5d06249d0f54c132dc6c018491))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`bca06e3`](https://github.com/NIDAP-Community/DSPWorkflow/commit/bca06e30849e378b3b73341fc27417d8e62ea5d2))

* Created vignette folder and added all integration test RMD files ([`638a7f0`](https://github.com/NIDAP-Community/DSPWorkflow/commit/638a7f06a79ef6852a0d4fdbfc5cf00db6e84a6a))

* Test multiple push change trackings ([`cba521d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/cba521d3f8ec8430f9e0b594e331812ebbe0da28))

* Test multiple push change trackings ([`5152e76`](https://github.com/NIDAP-Community/DSPWorkflow/commit/5152e768e54847bc375ab159c4f884b73151bd4c))

* Test multiple push change trackings ([`3242954`](https://github.com/NIDAP-Community/DSPWorkflow/commit/32429544a54edb22ff6dcf65958d76fc3282f515))

* Test multiple push change trackings ([`a4c18a8`](https://github.com/NIDAP-Community/DSPWorkflow/commit/a4c18a80f78db7d0be2f212d22b7433a377d14d1))

* Test multiple push change trackings ([`2657d67`](https://github.com/NIDAP-Community/DSPWorkflow/commit/2657d67d8e2f596f370ea24c1220a5af0d03649c))

* Update action files ([`c57c34a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c57c34af6eb5d6048049fde99ffedf4e075c6804))

* Test multiple file changes ([`5f15b39`](https://github.com/NIDAP-Community/DSPWorkflow/commit/5f15b39a1df4faefed5cce7de03eff3fd0dbdb5e))

* Update Docker recipes ([`5ea73d5`](https://github.com/NIDAP-Community/DSPWorkflow/commit/5ea73d5c1cc9d349f2e35e1cd5f8812777906a92))

* Update action files to better use docker container with conda ([`8a53f26`](https://github.com/NIDAP-Community/DSPWorkflow/commit/8a53f26ddc8534d34a814531b9b64a30b3d6d4b1))

* Test commit actions ([`f766a51`](https://github.com/NIDAP-Community/DSPWorkflow/commit/f766a5108980cd4eb898c933fd251c92f554a282))

* Test commit actions ([`342d636`](https://github.com/NIDAP-Community/DSPWorkflow/commit/342d636c00f542e7e51187fd99eaf76ba90664af))

* Test commit actions ([`fec0eb5`](https://github.com/NIDAP-Community/DSPWorkflow/commit/fec0eb5141649efbbaa02d3b5b5701e49dac18dc))

* Update commit action file ([`70b8b54`](https://github.com/NIDAP-Community/DSPWorkflow/commit/70b8b54eea0540673213d8ab2ce3281ddf96ce39))

* Update study_design.R

Signed-off-by: ruiheesi &lt;107956586+ruiheesi@users.noreply.github.com&gt; ([`58e9068`](https://github.com/NIDAP-Community/DSPWorkflow/commit/58e9068c6a1bf4b8b6375d4888f2afda0806b503))

* Delete DSP_pkg_test_2_13.log

Signed-off-by: ruiheesi &lt;107956586+ruiheesi@users.noreply.github.com&gt; ([`6b3036a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/6b3036aa4de340fcb62d1ff301ee2565f5276347))

* Incorporate CI ([`675d29e`](https://github.com/NIDAP-Community/DSPWorkflow/commit/675d29ed5d64b72c58174e632cb21122a3119b15))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`33061c5`](https://github.com/NIDAP-Community/DSPWorkflow/commit/33061c5bcb0d4e957dbe70954cf1833a3f35559d))

* add import patchwork and additional descriptions ([`54d91e8`](https://github.com/NIDAP-Community/DSPWorkflow/commit/54d91e892272d753a1cf51a0c6728318e3442a09))

* Updated for Species ([`600d400`](https://github.com/NIDAP-Community/DSPWorkflow/commit/600d4006a34e9612853eb4f01715b3624394044b))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`7845f2f`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7845f2f2e46675782d0b97cf46962b28c7c5a3c4))

* code cleanup for differential expression, tests ([`4040911`](https://github.com/NIDAP-Community/DSPWorkflow/commit/4040911afb427f8f1439e0f128264294653be177))

* Update test-heatmap.R ([`372b069`](https://github.com/NIDAP-Community/DSPWorkflow/commit/372b069404f71c0d0266b2c5d153a511bd8b12ec))

* update parameter and function format ([`eea9e3c`](https://github.com/NIDAP-Community/DSPWorkflow/commit/eea9e3c1f1d59563a58e0c34521140326468e5d7))

* Update ([`f77c4c1`](https://github.com/NIDAP-Community/DSPWorkflow/commit/f77c4c1a27a9933591e32d769ae2972b8b0355dc))

* Update ([`dc620a3`](https://github.com/NIDAP-Community/DSPWorkflow/commit/dc620a39f2ff5505ffa7688a98885742ab654709))

* Update to heatmap test script ([`51885cf`](https://github.com/NIDAP-Community/DSPWorkflow/commit/51885cf46403a1e11264f1edb28fd8e2c669b25c))

* Updated warnings in unsupervised script to be recognized by unit test ([`373edb7`](https://github.com/NIDAP-Community/DSPWorkflow/commit/373edb751112fc9d5984d27c6e693bb7f01b5bf2))

* Updates to integration tests and improvements to unsupervised unit test ([`ec38987`](https://github.com/NIDAP-Community/DSPWorkflow/commit/ec389873a29e2c3129aa121c02dd051aee624048))

* Updated for Species ([`56b3590`](https://github.com/NIDAP-Community/DSPWorkflow/commit/56b35903f71f7b3ffd42a7bb4127bff3ad20d15e))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`ffe45af`](https://github.com/NIDAP-Community/DSPWorkflow/commit/ffe45af31ff98e98230838210d289738a9cdae57))

* Changes to filtering for one RDS input and updating testing ([`5b3699c`](https://github.com/NIDAP-Community/DSPWorkflow/commit/5b3699c36820e9da53f3a8760ce0dde9e554245a))

* Update for unitest for four datasets ([`01402aa`](https://github.com/NIDAP-Community/DSPWorkflow/commit/01402aa7908219adc356730a17b551db38f8a133))

* Update for unitest for four datasets ([`447dbca`](https://github.com/NIDAP-Community/DSPWorkflow/commit/447dbcac7559b660a2794757b43efdd0417c00c3))

* Update for unitest for four datasets ([`2858e15`](https://github.com/NIDAP-Community/DSPWorkflow/commit/2858e15a3d07aa78c63de90c47ab089b45bee80e))

* Added check for required fields and error message, added test annotation sheet fixtures and a test for error message ([`2ae9a83`](https://github.com/NIDAP-Community/DSPWorkflow/commit/2ae9a834804bcb6af5d0da9de0eae029c4b13690))

* Updated helper function name and final test_that function ([`df4e26d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/df4e26d83f63abf122a5c6fb214d0d198e196af0))

* Added additional error and warning messagesto QC, updated QC test to check for messages ([`3a42a05`](https://github.com/NIDAP-Community/DSPWorkflow/commit/3a42a0560968939e19a25488e1001e09678f3e21))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`e561a03`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e561a037f0a4e58af95253430d62a6579c4482d8))

* Fixed issue with NULL inputs for NTCCounts, minNuclei, and minArea ([`e549a1c`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e549a1c6d5a79fed00b4e2969f3d614bebc342a5))

* changes to diff exp testing and code ([`fb4763b`](https://github.com/NIDAP-Community/DSPWorkflow/commit/fb4763b1f1cd7503d433c9873bb96e875093d281))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main

merge unit test code ([`524e78c`](https://github.com/NIDAP-Community/DSPWorkflow/commit/524e78cc370ba9ee333185251dff65c426e0a917))

* unit tests for DEG analysis ([`c4f7d63`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c4f7d6395dbf33fcd011407c0d16b3905d3d4f31))

* Updated pkc file path to fixtures ([`34888f1`](https://github.com/NIDAP-Community/DSPWorkflow/commit/34888f1fa99a24cc20be9eae822e25dc8694543c))

* Moved pkc files to fixtures, adjusted path in study design ([`10c8d69`](https://github.com/NIDAP-Community/DSPWorkflow/commit/10c8d6904ab797da7e9718e0c70694ff7a746e4a))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`52fc4ee`](https://github.com/NIDAP-Community/DSPWorkflow/commit/52fc4ee74b9cdc85d9744f3214a672bbe0841792))

* Added do.call method to study design and qc preprocessing tests ([`98c25e9`](https://github.com/NIDAP-Community/DSPWorkflow/commit/98c25e99e9f7ffc23829fc9f35018dd94481f17c))

* Fixed Bug ([`01bc430`](https://github.com/NIDAP-Community/DSPWorkflow/commit/01bc4307770961d3daa2b134e2b142a7dc621afe))

* Fixed Bug ([`bb45644`](https://github.com/NIDAP-Community/DSPWorkflow/commit/bb45644d00220b6b404ebfb1b6c14d860cd60833))

* Add deafult values in heatmap ([`2f68088`](https://github.com/NIDAP-Community/DSPWorkflow/commit/2f68088ad844dbeae26d44a3cacc8f967c1f1b50))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main

 the commit.

push to git ([`f929806`](https://github.com/NIDAP-Community/DSPWorkflow/commit/f929806260f26131e0c3ccc4b95003121477fa08))

* update unit test code for spat_deconv and violin ([`49ce858`](https://github.com/NIDAP-Community/DSPWorkflow/commit/49ce8580ab3807d906b260acbd6fe4e8c70c7d20))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`19a2014`](https://github.com/NIDAP-Community/DSPWorkflow/commit/19a2014fec9808fb9a42e77a529f4f7dceb347af))

* Created helper scripts for filtering and normalization, added do.call method to study design ([`19b02b0`](https://github.com/NIDAP-Community/DSPWorkflow/commit/19b02b0e50a2a7135ca24cff92c66d2b25c34ee2))

* add helper script for diff exp ([`6e13a00`](https://github.com/NIDAP-Community/DSPWorkflow/commit/6e13a0031e05a91af8c62338358e005bbad6a5bf))

* additional tests on diff expr ([`d844d8d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/d844d8da452590e9c247b9bb8a9d2d94bbaf3de5))

* Added helper test scripts and updated test files to use helpers ([`ab93421`](https://github.com/NIDAP-Community/DSPWorkflow/commit/ab93421b495c341fcf96a37334e26075df557d48))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`e72a72c`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e72a72cd0681657487707ca5c6a070437f11f73c))

* Added NULL conditional to nuclei, area, and NTC params for QC preprocessing step ([`e037c11`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e037c1156d57f20eca23d90d0e4a33baf1099b06))

* added expected errors ([`4a786a1`](https://github.com/NIDAP-Community/DSPWorkflow/commit/4a786a14ca9e65a5d0464fed06ae2798086233e6))

* added expected errors ([`1940245`](https://github.com/NIDAP-Community/DSPWorkflow/commit/1940245228351f3e6824d1e32c5ba6fa6d75b28e))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`b65019e`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b65019e6ab09d29454fbd1b074d87e3d50db9326))

* Updated fixtures, integration tests, and study design script
 Please enter the commit message for your changes. Lines starting ([`1c57ff3`](https://github.com/NIDAP-Community/DSPWorkflow/commit/1c57ff3be39fa817cfe07eca5fe5f7dc8a8b97ae))

* Errors added ([`27950be`](https://github.com/NIDAP-Community/DSPWorkflow/commit/27950be20bd2450e402493f9ccfe8af4e1342fe3))

* errors added ([`fbd7d49`](https://github.com/NIDAP-Community/DSPWorkflow/commit/fbd7d4971e1938020e68d398293ec4ab6876cd85))

* fixed conflicts ([`edcb337`](https://github.com/NIDAP-Community/DSPWorkflow/commit/edcb33777fb369bebea05f1b5252d7663e91b76c))

* specify order of groups/regions for DEG; added error messages ([`6868057`](https://github.com/NIDAP-Community/DSPWorkflow/commit/68680573ac8a5f9dedd0aee8e8b094579f557ee0))

* Updated ([`98b25d2`](https://github.com/NIDAP-Community/DSPWorkflow/commit/98b25d20b91aff96a840382ebbeffdf2ba40ea0e))

* Updated ([`b42e643`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b42e643c86d6cf22dd97e98affa1583efd737f94))

* Created fixture files for 4 datasets, steps 1-5, and edits to qc preprocessing for new datasets ([`acb19c1`](https://github.com/NIDAP-Community/DSPWorkflow/commit/acb19c1b73f4ae0a3514f375be5f3f719c7ba93b))

* Added integration test markdown file for NSCLC Dataset ([`5247200`](https://github.com/NIDAP-Community/DSPWorkflow/commit/52472005fe97a74dce5ac52c6957dba3dc63bad3))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`e2f7874`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e2f787424f7e25ba6c56f7058969c7c76c313073))

* Added Integration markdown tests for Mouse Thymus and Colon datasets. Modifications to diff exp R script ([`2fec11e`](https://github.com/NIDAP-Community/DSPWorkflow/commit/2fec11e8be684c613e649233d69304dca4704e51))

* update spatial deconv and violin ([`593c845`](https://github.com/NIDAP-Community/DSPWorkflow/commit/593c8452fda34d999051138396e651fc31201df3))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`a3f06fc`](https://github.com/NIDAP-Community/DSPWorkflow/commit/a3f06fcd1eb2311265caa0955a77a6684e3e1598))

* Changed hardcoded &#34;region&#34; column to user parameter ([`959044b`](https://github.com/NIDAP-Community/DSPWorkflow/commit/959044b9312bebb25e91124ec469b79e3cfc8dfb))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`cc5b55b`](https://github.com/NIDAP-Community/DSPWorkflow/commit/cc5b55bebdc16f28dfdb9cad4417e078a05e83df))

* Updated Integration test for Mouse Thymus data and updated Study Design Unit Test ([`6df9522`](https://github.com/NIDAP-Community/DSPWorkflow/commit/6df9522d93535e903e69bd35bb6390e5dc83caf5))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`be3228e`](https://github.com/NIDAP-Community/DSPWorkflow/commit/be3228e64d27e826cd97caf2e6f1564db575cae2))

* Changes to Differential Expression Analysis ([`9d103bd`](https://github.com/NIDAP-Community/DSPWorkflow/commit/9d103bd776fdd63babf8283a5e6314dc840c992b))

* update Unsupervised Analysis &amp; DESCRIPTION ([`1ac4608`](https://github.com/NIDAP-Community/DSPWorkflow/commit/1ac4608816f601a8d66976a99196ef67286a1c8d))

* Added Markdown file for Integration Testing. ([`da7e28a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/da7e28a7ffa3a436b6a4ec5eee808eec8ab99e53))

* Updated study design unit test ([`9e4a6d0`](https://github.com/NIDAP-Community/DSPWorkflow/commit/9e4a6d035b68cd55b584ec1a34cd69130f30f6c6))

* Changes to Differential Expression Analysis and Integration Test ([`6e70e1b`](https://github.com/NIDAP-Community/DSPWorkflow/commit/6e70e1bcce4d6883941547a2fe3cd43fa5d9a990))

* Integration test ([`aa78bff`](https://github.com/NIDAP-Community/DSPWorkflow/commit/aa78bff83d967bb68786695a77785a6641119f86))

* add integration test ([`fd211c0`](https://github.com/NIDAP-Community/DSPWorkflow/commit/fd211c07e0bb7ec81b938df9507b916068626084))

* update doc qc_preprocessing ([`dd82e69`](https://github.com/NIDAP-Community/DSPWorkflow/commit/dd82e69d9ebdf4ca28c3457edd9e1d229d3c5e0b))

* fixed conflicts ([`396baff`](https://github.com/NIDAP-Community/DSPWorkflow/commit/396baff797758f34e1d1ce062e44f7167bd02c82))

* hardcoded the path to the pkc file as for some reason, it does not resolve correctly when I run the test ([`73a2348`](https://github.com/NIDAP-Community/DSPWorkflow/commit/73a2348380bc8fee21d6131a9ee2893bda026eaf))

* removed NAMESPACE as it creates conflicts ([`c3263bf`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c3263bf9e53d1c2dc3ee209462a66ba17773d307))

* Update ([`a5fb987`](https://github.com/NIDAP-Community/DSPWorkflow/commit/a5fb987ee087350a86e6aeaf32dd46b9f47d19b2))

* Update testheatmap.R ([`16af7ba`](https://github.com/NIDAP-Community/DSPWorkflow/commit/16af7badac985ba8354323f5fdcd0c21640590c4))

* Update ([`73697b5`](https://github.com/NIDAP-Community/DSPWorkflow/commit/73697b52c29a96cf1e0da61cf55f2d99803c43f4))

* update fixtures dsp.obj.rds ([`fe27836`](https://github.com/NIDAP-Community/DSPWorkflow/commit/fe27836e8f9ccd75757316ea8a83e55465a9539b))

* adding man dir ([`1adad0f`](https://github.com/NIDAP-Community/DSPWorkflow/commit/1adad0fd84d13541dbc4cc7ecebecacb0f12f8f0))

* Confirmed changed on github ([`e502ca1`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e502ca17e813cfd636819f4ea213601b6827b7e6))

* changed test-study-design.R code for new annotation file ([`668bbe6`](https://github.com/NIDAP-Community/DSPWorkflow/commit/668bbe65d5c6ea9320ee967e0f8ee2fe42e31bc4))

* update ([`6b9ddd5`](https://github.com/NIDAP-Community/DSPWorkflow/commit/6b9ddd5dd5d86b384f2b26c1fa29565c34363f93))

* update ([`971c5ef`](https://github.com/NIDAP-Community/DSPWorkflow/commit/971c5ef7db74032385f902a14325e6a876b44bdf))

* correct percentStitched in plot qc_preprocessing ([`4c42cdb`](https://github.com/NIDAP-Community/DSPWorkflow/commit/4c42cdbd4552fb9ac9e77064b678640ef66776dc))

* update documentation qc_preprocessing ([`8436a74`](https://github.com/NIDAP-Community/DSPWorkflow/commit/8436a740ef24e602dc7ca40ad24d42514b42a32c))

* re-stash qc_preprocessing ([`3354b8e`](https://github.com/NIDAP-Community/DSPWorkflow/commit/3354b8ed24d58c6e64d693dc76128fe6ac026805))

* re-stash qc_processing.R ([`4cfc175`](https://github.com/NIDAP-Community/DSPWorkflow/commit/4cfc1753865a3b95d1d272f44c0383801d71c757))

* add dsp.obj.rds to fixtures ([`9b23443`](https://github.com/NIDAP-Community/DSPWorkflow/commit/9b2344390934d84413901cebb9b28dd69db2f3b6))

* add test-gc.preprocessing ([`eb1fda0`](https://github.com/NIDAP-Community/DSPWorkflow/commit/eb1fda0bf28293f6ce490f126a92555c88e443aa))

* first commitd qc_preprocessing ([`c6d28d7`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c6d28d75af726e05165c03a506ba90825ef1a72b))

* Updated ([`9bb6cd5`](https://github.com/NIDAP-Community/DSPWorkflow/commit/9bb6cd5caf21d62e10025170988579b35a97dd13))

* Updated Filtering Lib ([`2479487`](https://github.com/NIDAP-Community/DSPWorkflow/commit/2479487ec9598d7d0126379fe183d809ef0f86ee))

* Updated Filtering Lib ([`7aed732`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7aed7325da284672dab10fd28b10025d17f4aa42))

* “Update” ([`f9ad5ad`](https://github.com/NIDAP-Community/DSPWorkflow/commit/f9ad5ad57a0b28eef55ad1e8487cebe00cf9cea0))

* “Update” ([`5aa0367`](https://github.com/NIDAP-Community/DSPWorkflow/commit/5aa0367c659b3d5d3b3b51cb22a758661d93ca84))

* “Update” ([`a373537`](https://github.com/NIDAP-Community/DSPWorkflow/commit/a3735379921cbdef3c08ec5cb902a3c3d3f6cc0e))

* add violin function ([`6b15fbd`](https://github.com/NIDAP-Community/DSPWorkflow/commit/6b15fbd4b08e0dbc2a8c623959ea6c036606b5f4))

* Filtering ([`5567090`](https://github.com/NIDAP-Community/DSPWorkflow/commit/556709075ec0aa70c0a1f9f2fa79f97a5a2c2f6f))

* Filtering ([`63301d1`](https://github.com/NIDAP-Community/DSPWorkflow/commit/63301d11da1b6d9e7d3a982bf3854ff3086df2f5))

* Filtering ([`43e4055`](https://github.com/NIDAP-Community/DSPWorkflow/commit/43e4055878af05a95e71728bc3cd7fdf96002405))

* Filtering ([`5b41df2`](https://github.com/NIDAP-Community/DSPWorkflow/commit/5b41df23e73643386f55354d881745fb73adc5ac))

* Filtering Test ([`74b56ce`](https://github.com/NIDAP-Community/DSPWorkflow/commit/74b56ce2e2eaf51dea825cb073c1cc2ec8133134))

* Updated Fx ([`bd05cb9`](https://github.com/NIDAP-Community/DSPWorkflow/commit/bd05cb965bcaa263542149868b16326a83beedd6))

* Filtering Packages Add ([`87949f0`](https://github.com/NIDAP-Community/DSPWorkflow/commit/87949f0393b236f8522993e6e8fc120f5d1c8677))

* fixed warning related to global variable ([`54abb0b`](https://github.com/NIDAP-Community/DSPWorkflow/commit/54abb0be78f82542f03c4146aa1bb7ede8768ce8))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`c08bf71`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c08bf716acc64421d48400a99cd64f58a1f30108))

* remove tidyverse incompatible code ([`9832f49`](https://github.com/NIDAP-Community/DSPWorkflow/commit/9832f498edf4f9519020e2896421f9a9eb254831))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`c70e393`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c70e3932d79988302a69ce39ff0a3b4d35345516))

* changed data to object ([`b469837`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b46983783ad21a587ca36f616507237451a3ac5c))

* Fixed conflicts in NAMESPACE ([`871e3ba`](https://github.com/NIDAP-Community/DSPWorkflow/commit/871e3ba91b86b32b75ce309d304a6902db0c1d95))

* Updated NAMESPACE ([`2bab123`](https://github.com/NIDAP-Community/DSPWorkflow/commit/2bab123a8dd970b99506f657eebfb007b19fcb2e))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`2642d36`](https://github.com/NIDAP-Community/DSPWorkflow/commit/2642d3681f5c11c840dca2a94d261bf6ffb8dbdb))

* Updated ([`33e0a1d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/33e0a1d4532adde6c3cced7d659d326998372778))

* assign target.Data for rds ([`0dc3b0d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/0dc3b0d61bd22624d180bfa2203b60a2592bcb8a))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`86e6644`](https://github.com/NIDAP-Community/DSPWorkflow/commit/86e664445d7d69d397af962b57b25be31647d2a4))

* update test - read rds ([`d8d5452`](https://github.com/NIDAP-Community/DSPWorkflow/commit/d8d5452df49bb30469ddd52c5934404f4761a5ca))

* update heatmap ([`c93a8a3`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c93a8a3166f488a6525174d16502db24d23f4d61))

* update test-heatmap ([`3c093dc`](https://github.com/NIDAP-Community/DSPWorkflow/commit/3c093dc6c253f3d5221d6cee281cbe4b0e5cdfd9))

* update DESCRIPTION ([`7b72469`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7b7246964f09b02a5be1f3c219a39d7fb92d39e7))

* update DESCRIPTION ([`7af8b4a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7af8b4a80981d2fe7da7cf4640407efa6f34d9ad))

* update NAMESPACE ([`c678325`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c6783255a41a82fc88562487ce5dc3674050c327))

* update spatial_deconv ([`3673abe`](https://github.com/NIDAP-Community/DSPWorkflow/commit/3673abe02fbbe93ceadae9bb15baf0d7175e98a2))

* updates heatmap ([`e640a39`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e640a3996e5e55009a0cb16fc2e9c24ca1afcba8))

* updates to diffExpr ([`8634907`](https://github.com/NIDAP-Community/DSPWorkflow/commit/863490740af8bd7c007902346335a68c4967c597))

* synchronizing ([`e88ca33`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e88ca33789924404a14702cdad3ab7b81e3e63ae))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`898dd7f`](https://github.com/NIDAP-Community/DSPWorkflow/commit/898dd7fc2c1cfcf71f4ad74cb8ff1b9b0cbf42f7))

* resolve conflict ([`75bde30`](https://github.com/NIDAP-Community/DSPWorkflow/commit/75bde301e7ea2edf5ac2325e27832b1d0720c0b9))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`d2571ff`](https://github.com/NIDAP-Community/DSPWorkflow/commit/d2571ffa2d746812221fadebced9af3331ed46d0))

* update ([`b8195d0`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b8195d04a43743326c8f051ef49131a8e7a7299a))

* Norm Test Data ([`6ab4b01`](https://github.com/NIDAP-Community/DSPWorkflow/commit/6ab4b014b86154d46d004d3403c999393f20b9e1))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main

update local rep ([`2173b63`](https://github.com/NIDAP-Community/DSPWorkflow/commit/2173b639524aecba7a0a964d24a90745c071aabf))

* fix conflicts ([`c4a4fae`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c4a4fae966e69e66b2413e2d42a2cde64b74f4cf))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main

merge ([`7766a30`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7766a300b0e0a5def3c51185946b4bd775ab1900))

* removed anndaata ([`920227e`](https://github.com/NIDAP-Community/DSPWorkflow/commit/920227e0e6b975147f72da194073d6b610b64927))

* update ([`947d9d5`](https://github.com/NIDAP-Community/DSPWorkflow/commit/947d9d58c50357c4edd3968e2758fc24cf2fd735))

* Changed results column names ([`962fb2f`](https://github.com/NIDAP-Community/DSPWorkflow/commit/962fb2fef245cf56e83eff83e3cf43bc4d6ad6c0))

* R/normalization.R ([`6f472af`](https://github.com/NIDAP-Community/DSPWorkflow/commit/6f472af846939557d41cba331a6b02101d63db1c))

* initialized local variables to NULL ([`cd2cac9`](https://github.com/NIDAP-Community/DSPWorkflow/commit/cd2cac938a5ba327788d11fe2363f7d75664dc2d))

* add to namespace ([`ab33e29`](https://github.com/NIDAP-Community/DSPWorkflow/commit/ab33e299ecd26ed3c126cdaf3e51e3b8a6e844e7))

* add to description ([`72bbbb0`](https://github.com/NIDAP-Community/DSPWorkflow/commit/72bbbb0f9e1d43f51772a935183c213386e75326))

* bind variables ([`777efc3`](https://github.com/NIDAP-Community/DSPWorkflow/commit/777efc3640d50c1b95d774db3f74fcaa15abdac4))

* update target.Data.rda ([`24b9c8a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/24b9c8a3c6b821258fa4e0cf1d9ba40ec7754f9b))

* update importFrom ([`115c022`](https://github.com/NIDAP-Community/DSPWorkflow/commit/115c022ccfcec6f3d22706ee55d44fd405436c08))

* update NAMESPACE ([`99a8808`](https://github.com/NIDAP-Community/DSPWorkflow/commit/99a88088e5954f049711daf61863136ab95f4ee6))

* update DESCRIPTION ([`6c8d24c`](https://github.com/NIDAP-Community/DSPWorkflow/commit/6c8d24c566179c25b1386087a8f806459443b88d))

* resolve imports ([`e64c978`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e64c9787549aa7371b638434a9aad0ccf686f077))

* update NAMESPACE ([`b3455c6`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b3455c6f591d5ed43c22c3f41085eaf383d3c293))

* add Dependencies ([`47e6739`](https://github.com/NIDAP-Community/DSPWorkflow/commit/47e6739f62aa733771d064b576117b21bd4b9766))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`1b888b3`](https://github.com/NIDAP-Community/DSPWorkflow/commit/1b888b34a0ad5062922fcf6c2ff2826087dab2ad))

* Norm Test Dataset ([`4858fea`](https://github.com/NIDAP-Community/DSPWorkflow/commit/4858feada0ae8c15f69da72287d6f801148609e3))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`30cf956`](https://github.com/NIDAP-Community/DSPWorkflow/commit/30cf956ea7616d3e507c4625f781c73615b5c18d))

* Add test code ([`4cf6352`](https://github.com/NIDAP-Community/DSPWorkflow/commit/4cf6352bd2040056dc7685f9a09540e69e48d3ad))

* added importFrom for all used functions ([`788c500`](https://github.com/NIDAP-Community/DSPWorkflow/commit/788c500a0476e150e84e963d6b392e5159e76410))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`dc7370a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/dc7370a35a2acd5491856962304f877189cd1ad4))

* returned list of output files ([`38a63a1`](https://github.com/NIDAP-Community/DSPWorkflow/commit/38a63a19c5ca988c6694a788e17405a045977ee5))

* returned list of output files ([`a6d04b0`](https://github.com/NIDAP-Community/DSPWorkflow/commit/a6d04b084908f9e4abd920faa8e9aa0411ea9325))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`422ec99`](https://github.com/NIDAP-Community/DSPWorkflow/commit/422ec99f7bedf08d0fe3718d68747b8e950be961))

* update unsupervised_analysis ([`db4b4fd`](https://github.com/NIDAP-Community/DSPWorkflow/commit/db4b4fd5e5684d78c31c70639b96caf630e250b8))

* set relative paths in test ([`7116b5d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7116b5d924869e0e0210f560b936b019502fb8ca))

* added tidyverse and gridExtra ([`e3c5167`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e3c5167045c6c3ab0581c8c41a3450ac5c161f21))

* update spatial deconv ([`6f66fa3`](https://github.com/NIDAP-Community/DSPWorkflow/commit/6f66fa30db60eff1662b533e9e7d550c132bd13c))

* changed Depends to Imports ([`b1d8b00`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b1d8b00075829463af1c53541786fc09104b3080))

* First commit ([`1e2761e`](https://github.com/NIDAP-Community/DSPWorkflow/commit/1e2761e19f41be5156ad9cc7e399254fd00c02a6))

* backing up spatial convolution code ([`82f23ed`](https://github.com/NIDAP-Community/DSPWorkflow/commit/82f23eda54a384f3c93182f823375aded4b4c15f))

* remove load_all ([`192bb96`](https://github.com/NIDAP-Community/DSPWorkflow/commit/192bb96c72ef4fd1a7ba4a42387ab68da0e0d940))

* load test_path fixtures ([`0a16efe`](https://github.com/NIDAP-Community/DSPWorkflow/commit/0a16efe0dbc5ad52b14ba21f585732478ecf7c0b))

* update fixtures ([`06de85d`](https://github.com/NIDAP-Community/DSPWorkflow/commit/06de85dd3d133cef1903c426de8b37a119bfaf94))

* update DESCRIPTION ([`99cc8c6`](https://github.com/NIDAP-Community/DSPWorkflow/commit/99cc8c6348907dcdf2bfab84f0924bae3da5b79c))

* description edit ([`a57bfdf`](https://github.com/NIDAP-Community/DSPWorkflow/commit/a57bfdfa47dd64dc050b3fb5f40b4aa07d96cf42))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main

Conflicts:
	DESCRIPTION
	NAMESPACE ([`6631fc3`](https://github.com/NIDAP-Community/DSPWorkflow/commit/6631fc351980a030ec6025fa693e0c65eb8d3d67))

* update dependencies ([`8a8bbc6`](https://github.com/NIDAP-Community/DSPWorkflow/commit/8a8bbc69d42b602aa11eba56727e19561099d705))

* update function name, import ([`357f7fa`](https://github.com/NIDAP-Community/DSPWorkflow/commit/357f7fad2a94a49a5a5914c139f2084f669c9a19))

* update function name, import ([`e00ac2c`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e00ac2c0a94943819cb5eedcda5b2059d4a7df4d))

* odrdered the depends section alphabetically ([`7b37e7a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7b37e7ac31601d99f7ce8c895e2f7135473a3bc2))

* add fixtures folder ([`1d21d98`](https://github.com/NIDAP-Community/DSPWorkflow/commit/1d21d98a8c8b1e1afa59ceed03b49d81d1790d51))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`c2f69ee`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c2f69ee160f220cc54ea0a3ae9068098958b89c6))

* fixed NAMESPACE conflict ([`ab01f29`](https://github.com/NIDAP-Community/DSPWorkflow/commit/ab01f293f38ff60ac8bb43450427e6eea0601480))

* Update ([`13b1bc6`](https://github.com/NIDAP-Community/DSPWorkflow/commit/13b1bc68dbfa79dfdb57b65a1f26ed8aa323d82c))

* Initial commit ([`baa5514`](https://github.com/NIDAP-Community/DSPWorkflow/commit/baa5514a98370d6f2155a3ea667bf12d174ec461))

* add color.variable param ([`7ed468a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7ed468a187c83aef53568307bb7883c3a43eb961))

* initial commit ([`7e4255f`](https://github.com/NIDAP-Community/DSPWorkflow/commit/7e4255f1b67c7794989d94daf849b60b9ad3860c))

* add @import and rename function and params ([`fb5a86b`](https://github.com/NIDAP-Community/DSPWorkflow/commit/fb5a86b5d25a8fe61d7dff800dddf554a1f9f9c8))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`9286d6b`](https://github.com/NIDAP-Community/DSPWorkflow/commit/9286d6b5967ace1295acf23aa592bc12822948ce))

* initial commit ([`4b79ebd`](https://github.com/NIDAP-Community/DSPWorkflow/commit/4b79ebd60a3b4696ff893a2f818ec765722ff631))

* Normalization Unit Test ([`b3b51e4`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b3b51e46f72e5b9c9d75aacd90847d0a1a524722))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`43e94fb`](https://github.com/NIDAP-Community/DSPWorkflow/commit/43e94fb4d516dd91414ed907888705d7b34079c4))

* Merge branch &#39;main&#39; of https://github.com/NIDAP-Community/DSPWorkflow into main ([`b93bd2a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b93bd2ada3340bee0087d89e4451624c1af78b2a))

* Rename the function StudyDesign and added dependencies to the DESCRIPTION file ([`b4bf7e4`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b4bf7e490c617aca307e516e9e22929716ae6d2e))

* Delete test-normalization.R ([`84025c7`](https://github.com/NIDAP-Community/DSPWorkflow/commit/84025c79c5a531f33399d6413da14733d4e83008))

* Updated function ([`9aeec48`](https://github.com/NIDAP-Community/DSPWorkflow/commit/9aeec487ec79884bc47da7dc3f5a2d668ddc4b1b))

* Initial commit ([`b246883`](https://github.com/NIDAP-Community/DSPWorkflow/commit/b246883ae2810570a9c504d05d9748161e9fe2dd))

* Add files via upload ([`415666a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/415666a37913d2efcb782443f270d8dfddb0f4f1))

* Delete test-normalization.R ([`8f72dea`](https://github.com/NIDAP-Community/DSPWorkflow/commit/8f72dea13713a5599df5d187744f2ca6dad0ec85))

* Add files via upload ([`09fed03`](https://github.com/NIDAP-Community/DSPWorkflow/commit/09fed03f515ad7ef1258533e3d0a2fe6e4f56905))

* Initial commit ([`91a3501`](https://github.com/NIDAP-Community/DSPWorkflow/commit/91a3501638d751cd018e6d9eb0a5ede92613b618))

* added project artifacts ([`fcf73f9`](https://github.com/NIDAP-Community/DSPWorkflow/commit/fcf73f9175711502163bb84ba42f29b21b9af4b2))

* first implementation of study design function ([`72abdc2`](https://github.com/NIDAP-Community/DSPWorkflow/commit/72abdc2120092ef0503c438881fac102fa7a5ed4))

* Commented example code ([`5c82d69`](https://github.com/NIDAP-Community/DSPWorkflow/commit/5c82d6943ab254779e37a836fdc36c7fa568c8d4))

* prototype of study design ([`ec478ae`](https://github.com/NIDAP-Community/DSPWorkflow/commit/ec478ae82ff68b14603d0cd32fcf76bafd041011))

* Rearranged folders ([`c97858a`](https://github.com/NIDAP-Community/DSPWorkflow/commit/c97858ab6c152152dfd3cda75ef51f434606859b))

* Added new R files ([`29f1609`](https://github.com/NIDAP-Community/DSPWorkflow/commit/29f1609a8ae1636c163d716ce3ad3d551f17c05d))

* Initial try ([`559a985`](https://github.com/NIDAP-Community/DSPWorkflow/commit/559a98520cd99d7e07550434803c171a5e40568a))

* Initial commit ([`e439dce`](https://github.com/NIDAP-Community/DSPWorkflow/commit/e439dce5040c825013276f9e460ab30e1d2ea729))
