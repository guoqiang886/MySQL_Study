# 创建部门表
CREATE TABLE dept(
id INT PRIMARY KEY AUTO_INCREMENT,
NAME VARCHAR(20)
);
INSERT INTO dept (NAME) VALUES('开发部'),('市场部'),('财务部');
# 创建员工表
CREATE TABLE emp (
id INT PRIMARY KEY AUTO_INCREMENT,
NAME VARCHAR(10),
gender CHAR(1), -- 性别
salary DOUBLE, -- 工资
join_date DATE, -- 入职日期
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES dept(id) -- 外键，关联部门表(部门表的主键)
);
INSERT INTO emp(NAME,gender,salary,join_date,dept_id) VALUES('孙悟空','男',7200,'2013-02-24',1);
INSERT INTO emp(NAME,gender,salary,join_date,dept_id) VALUES('猪八戒','男',3600,'2010-12-02',2);
INSERT INTO emp(NAME,gender,salary,join_date,dept_id) VALUES('唐僧','男',9000,'2008-08-08',2);
INSERT INTO emp(NAME,gender,salary,join_date,dept_id) VALUES('白骨精','女',5000,'2015-10-07',3);
INSERT INTO emp(NAME,gender,salary,join_date,dept_id) VALUES('蜘蛛精','女',4500,'2011-03-14',1);

SELECT * FROM dept;
SELECT * FROM emp;
SELECT * FROM dept, emp;

-- 查询所有员工和对应的部门信息
SELECT * FROM dept,emp WHERE dept.id = emp.`dept_id`;

-- 查询员工表的名称，性别，部门表的名称
SELECT emp.name, emp.gender, dept.name FROM dept, emp WHERE dept.`id` = emp.`dept_id`;

-- 可以给表起别名再查询
SELECT
	e.`name`, e.`gender`, t.`name`
FROM
	emp e, dept t
WHERE
	e.`dept_id` = t.`id`;
	
-- 显式内连接
SELECT * FROM emp INNER JOIN dept WHERE dept.`id` = emp.`dept_id`;
SELECT * FROM emp JOIN dept WHERE dept.`id` = emp.`dept_id`;

-- 左外连接查询
SELECT emp.*, dept.`name` FROM emp LEFT OUTER JOIN dept ON dept.`id` = emp.`dept_id`;

-- 右外连接查询
SELECT emp.*, dept.`name` FROM dept RIGHT JOIN emp ON dept.`id` = emp.`dept_id`;

-- 子查询
SELECT * FROM emp WHERE emp.`salary` = (SELECT MAX(salary) FROM emp);

-- 子查询结果是多行单列
SELECT * FROM emp WHERE emp.`dept_id` IN (SELECT id FROM dept WHERE NAME = '财务部' OR NAME = '开发部');

# 练习
-- 查询出部门编号，部门名称, 部门人数
SELECT * FROM dept;
SELECT * FROM emp;

SELECT
	t1.`id`, t1.`name`, t2.部门人数
FROM 
	dept t1, (
		SELECT 
			dept_id, COUNT(id) 部门人数
		FROM
			emp
		GROUP BY
			dept_id) t2
WHERE 
	t1.id = t2.dept_id;



-- 清空db2的表
DROP TABLE emp;
DROP TABLE dept;

-- 下面是练习


-- 部门表
CREATE TABLE dept (
  id INT PRIMARY KEY PRIMARY KEY, -- 部门id
  dname VARCHAR(50), -- 部门名称
  loc VARCHAR(50) -- 部门所在地
);

-- 添加4个部门
INSERT INTO dept(id,dname,loc) VALUES 
(10,'教研部','北京'),
(20,'学工部','上海'),
(30,'销售部','广州'),
(40,'财务部','深圳');



-- 职务表，职务名称，职务描述
CREATE TABLE job (
  id INT PRIMARY KEY,
  jname VARCHAR(20),
  description VARCHAR(50)
);

-- 添加4个职务
INSERT INTO job (id, jname, description) VALUES
(1, '董事长', '管理整个公司，接单'),
(2, '经理', '管理部门员工'),
(3, '销售员', '向客人推销产品'),
(4, '文员', '使用办公软件');



-- 员工表
CREATE TABLE emp (
  id INT PRIMARY KEY, -- 员工id
  ename VARCHAR(50), -- 员工姓名
  job_id INT, -- 职务id
  mgr INT , -- 上级领导
  joindate DATE, -- 入职日期
  salary DECIMAL(7,2), -- 工资
  bonus DECIMAL(7,2), -- 奖金
  dept_id INT, -- 所在部门编号
  CONSTRAINT emp_jobid_ref_job_id_fk FOREIGN KEY (job_id) REFERENCES job (id),
  CONSTRAINT emp_deptid_ref_dept_id_fk FOREIGN KEY (dept_id) REFERENCES dept (id)
);

-- 添加员工
INSERT INTO emp(id,ename,job_id,mgr,joindate,salary,bonus,dept_id) VALUES 
(1001,'孙悟空',4,1004,'2000-12-17','8000.00',NULL,20),
(1002,'卢俊义',3,1006,'2001-02-20','16000.00','3000.00',30),
(1003,'林冲',3,1006,'2001-02-22','12500.00','5000.00',30),
(1004,'唐僧',2,1009,'2001-04-02','29750.00',NULL,20),
(1005,'李逵',4,1006,'2001-09-28','12500.00','14000.00',30),
(1006,'宋江',2,1009,'2001-05-01','28500.00',NULL,30),
(1007,'刘备',2,1009,'2001-09-01','24500.00',NULL,10),
(1008,'猪八戒',4,1004,'2007-04-19','30000.00',NULL,20),
(1009,'罗贯中',1,NULL,'2001-11-17','50000.00',NULL,10),
(1010,'吴用',3,1006,'2001-09-08','15000.00','0.00',30),
(1011,'沙僧',4,1004,'2007-05-23','11000.00',NULL,20),
(1012,'李逵',4,1006,'2001-12-03','9500.00',NULL,30),
(1013,'小白龙',4,1004,'2001-12-03','30000.00',NULL,20),
(1014,'关羽',4,1007,'2002-01-23','13000.00',NULL,10);



-- 工资等级表
CREATE TABLE salarygrade (
  grade INT PRIMARY KEY,   -- 级别
  losalary INT,  -- 最低工资
  hisalary INT -- 最高工资
);

-- 添加5个工资等级
INSERT INTO salarygrade(grade,losalary,hisalary) VALUES 
(1,7000,12000),
(2,12010,14000),
(3,14010,20000),
(4,20010,30000),
(5,30010,99990);

-- 需求：

-- 1.查询所有员工信息。查询员工编号，员工姓名，工资，职务名称，职务描述

-- 2.查询员工编号，员工姓名，工资，职务名称，职务描述，部门名称，部门位置
   
-- 3.查询员工姓名，工资，工资等级

-- 4.查询员工姓名，工资，职务名称，职务描述，部门名称，部门位置，工资等级

-- 5.查询出部门编号、部门名称、部门位置、部门人数
 
-- 6.查询所有员工的姓名及其直接上级的姓名,没有领导的员工也需要查询

-- 练习一
SELECT
	emp.`id`, 
	emp.`ename`, 
	emp.`salary`, 
	job.`jname`, 
	job.`description`
FROM
	emp
LEFT JOIN 
	job
ON 
	emp.`job_id` = job.`id`;


-- 练习二
SELECT
	emp.`id`,
	emp.`ename`,
	emp.`salary`,
	job.`jname`,
	job.`description`,
	dept.`dname`,
	dept.`loc`
FROM
	emp,
	job,
	dept
WHERE
	emp.`job_id` = job.`id`
	AND emp.`dept_id` = dept.`id`;


-- 练习三
SELECT
	emp.`ename`,
	emp.`salary`,
	salarygrade.`grade`
FROM
	emp,
	salarygrade
WHERE
	emp.`salary` BETWEEN salarygrade.`losalary` AND salarygrade.`hisalary`;
	

-- 练习四
SELECT
	emp.`ename`,
	emp.`salary`,
	job.`jname`,
	job.`description`,
	dept.`dname`,
	dept.`loc`,
	salarygrade.`grade`
FROM
	emp,
	job,
	dept,
	salarygrade
WHERE
	emp.`job_id` = job.`id`
	AND emp.`dept_id` = dept.`id`
	AND emp.`salary` BETWEEN salarygrade.`losalary` AND salarygrade.`hisalary`;
	

-- 练习五
SELECT
	dept.*,
	t1.num
FROM
	dept
LEFT OUTER JOIN
	(
	SELECT
		emp.`dept_id` id, 
		COUNT(emp.`id`) num
	FROM
		emp
	GROUP BY
		emp.`dept_id`) t1
ON dept.`id` = t1.id;

-- 练习六
SELECT
	t1.ename 员工,
	t2.ename 老板
FROM
	emp t1
LEFT JOIN
	emp t2
ON t1.`mgr` = t2.`id`;	