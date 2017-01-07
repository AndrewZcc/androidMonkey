## Monkey 运行指南

> 本机位置：`~/Desktop/paper/Backup/constrast_experi/ATGT/monkey`

1. 进入目录，<font color="blue">修改 `projects.txt`</font> 指明 AUT 信息;

2. 执行 Monkey 测试 <font color="blue">`sh run_monkey.sh`</font>
	- 本步骤会产生覆盖率文件，位于 `./results/AUT/*.em|ec`;

3. 执行 <font color="blue">`sh rename_ec.sh AUT_Name`</font>，将所有的 EC文件按照顺序编好号并存入 temp 目录下；
	- eg: `sh rename_ec.sh net.fercanet.LNM_3_src`

4. 执行 <font color="blue">`sh genEmmaReport.sh AUT_Name int(50)`</font>，利用所有的 EM|EC 文件生成 Emma-HTML 覆盖率报告。
	- eg: `sh genEmmaReport.sh net.fercanet.LNM_3_src 39` // 39 代表EC文件有39个(代表个数)

