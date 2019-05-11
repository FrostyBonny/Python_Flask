# Python_Flask
python的flask后台，用于创新基金


## 使用

需要在utils目录下创建一个SQLconfig并且在里面填入你自己的数据库信息。
SQL_ADDRESS = '' # 数据库ip
SQL_DATABASE = '' # 数据库名字
SQL_USERNAME = ''  # 数据库账号
SQL_PASSWORD = ''  # 数据库密码

## 数据库

数据库表结构见./databaseBack

直接运行sql即可

## 代办事项
- [x] 使用装饰器完成数据库的每次单独连接
- [ ] 设计token验证

## 教程：如何在现有的基础上拓展功能。

具体流程：</br>
1. 添加蓝图
2. 添加接口
3. 验证每个接口接收的数据
4. 完成具体的功能

知识点：
- flask中的蓝图
- restful风格的接口
- 数据库类的使用
- token验证

### 1、flask中的蓝图
[官方链接](http://flask.pocoo.org/docs/1.0/tutorial/views/)</br>
[中文教程链接](https://dormousehole.readthedocs.io/en/latest/tutorial/views.html)

> 简单的来说就是每个模块就是一个蓝图，蓝图需要注册。</br>
视图就是蓝图的组成，具体到哪个功能上。

在该项目框架中需要在./src 中的__init__.py中，添加你的蓝图信息。
![](https://note.youdao.com/yws/public/resource/1b607f4e365d84f9a37c20647f436fcd/xmlnote/1018BF2CFF8541DCB896BDA0CCEA80AB/1913)</br>
在此处添加蓝图。例如在此处的src.veiws.user:user则代表需要在./src/veiws/user中的__init__.py创建user蓝图。
```
./src/veiws/user/__init__.py

from flask import Blueprint

user = Blueprint('user', __name__, url_prefix='/user')

from . import veiw
```
这是每个蓝图的__init__.py。需要将Blueprint中的第一个参数改为唯一的。url_prefix后即为接在访问地址后面的接口。

### 2、restful风格
[阮一峰文章](http://www.ruanyifeng.com/blog/2014/05/restful_api.html)</br>
笔者此处采用了flask_restful插件。[官方文档地址](https://flask-restful.readthedocs.io/en/latest/)</br>
> 在此处笔者将post和put弄反，目前未做修改。

接下来我们来看./src/veiws/user/veiw.py
</br>
简化后为：
```
from flask_restful import Api, Resource, url_for, abort
from . import user
# from .parser import putPaeser, getParser
from . import parser as allParser
# from ... import dbclient
from src import dbclient
from flask import jsonify,request
from utils.code import Code
from utils.function import make_result, make_token, verify_token, encode_password,dbclient_decorate

table = 'my_users'
api = Api(user)
class Login(Resource):
    #  登录
    @dbclient_decorate
    def post(self):
        
    
    def get(self):
        



api.add_resource(Login, '/login',endpoint='userLogin')

class Login_Out(Resource):
    @dbclient_decorate
    def post(self):
        

api.add_resource(Login_Out, '/loginout',endpoint='userLoginOut')

class User(Resource):
    #  获取
    @dbclient_decorate
    def get(self):
       


    #  更新
    @dbclient_decorate
    def post(self):


    #  删除
    @dbclient_decorate
    def delete(self):
        


    #  新增
    @dbclient_decorate
    def put(self):
        
    

api.add_resource(User, '/user',endpoint='user')
```
- 首先table为该这个蓝图控制的表，由于该项目的数据库表结构设计的不复杂，所以一个蓝图对应一个数据表。
- api见rest_ful插件使用
- @dbclient_decorate为数据库每次连接以及关闭的装饰器，需要操作数据库的需要添加该代码
- 里面为get....post这样的接口操作
- api.add_resource(User, '/user',endpoint='user')官方文档[地址](https://flask-restful.readthedocs.io/en/latest/api.html#flask_restful.Api.add_resource)
简单解释一下就是：第一个参数，和endpoint唯一，第二个参数为访问地址的组成部分。比如此处的访问地址为127.0.0.1:5000/user/user

此为veiw.py大体结构
### 3、接收前台数据

官方文档[地址](https://flask-restful.readthedocs.io/en/latest/api.html#module-reqparse)</br>

之间看parser.py的一部分：
```
putUserParser = reqparse.RequestParser()
putUserParser.add_argument('username', type=str, help='please enter username', required=True)
putUserParser.add_argument('password', type=str, help='please enter password', required=True)
putUserParser.add_argument('role', type=str, help='please enter role', required=True)
putUserParser.add_argument('name', type=str, help='please enter name', required=True)
```
此处为官方文档给的写法的模仿版。
</br>
先简单解释一下：先添加了一个验证器。
然后再验证器中添加了很多的参数，add_argument中的第一个参数为参数名，然后为数据类型，help为数据没有通过验证的提示信息，最后为数据时候必须。
该函数还有更大的功能，但是笔者此处没有使用。
</br>
该验证器的使用如下：
```
args = allParser.putUserParser.parse_args()
```
使用之后args则包含所有通过验证的参数。

</br>
但是如果这样写会导致参数越多，行数越多，不利于维护。
故笔者做了以下尝试：

```
putUserParser = reqparse.RequestParser()

putUserParserRules = [{
        "name":"username",
        "type":str,
        "help":"please enter username",
        "required":True,
    },{
        "name":"password",
        "type":str,
        "help":"please enter password",
        "required":True,
    },{
        "name":"role",
        "type":str,
        "help":"please enter role",
        "required":True,
    },{
        "name":"name",
        "type":str,
        "help":"please enter name",
        "required":True,
    }]
for i in putUserParserRules:
    putUserParser.add_argument(i['name'], type=i['type'], help=i['help'], required=i['required'])
```
在这种情况下，代码变得比较容易维护。
但是由于突发奇想，笔者也只做了这一小部分。

### 4、数据库操作。

可以直接去看./utils/mysql.py。代码做了比较详细的注释，有数据库基础的应该都知道笔者在干什么，由于这个类是最先动手的，其中有些地方写的不是很好，功能也相对简单，等一手重写。
### 5、完成具体的接口功能。
此处流程为：
1. 获取到前端数据
2. 将数据进行处理
3. 数据库进行操作
4. 将结果返回

拿具体的功能进行举例：
```
    @dbclient_decorate
    def delete(self):
        args = allParser.deleteParser.parse_args()
        verify_result = verify_token(args["token"])
        if not verify_result:
            return make_result(code=Code.ERROR)
        args.pop('token')
        result = dbclient.delete(table,{"id":args['id']})
        if result:
            response = make_result(code=Code.SUCCESS,msg="删除成功")
        else:
            response = make_result(code=Code.ERROR,msg="删除失败")
        return response
```
在此处，先获取了前端参数，再验证了token，随后便是数据库操作，随后返回结果。
</br>
更多实例查看代码即可。
### 6、token 机制
本项目使用的是随机生成token，存入数据库，每次登陆的时候会修改数据库的token字段，相应有个触发器监听token字段的更新，从而下次带有token的访问来的时候便可以验证其有效时间。

具体实现之后再补。
目前只需要在需要验证token的接口中加入
```
verify_result = verify_token(args["token"])
```
并且在数据验证中加入：
```
getUserParser.add_argument('token', type=str, location='headers')
```
即可验证在header中的token