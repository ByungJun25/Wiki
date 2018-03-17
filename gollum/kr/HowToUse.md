# Gollum 사용방법  

1. [Github](https://github.com/)에 위키페이지로 사용할 repository를 생성한다.  
2. 생성된 repository를 clone한 후, clone된 폴더내에서 git bash 실행.  
3. 다음의 명령어를 통해 gollum 서버를 실행할 수 있다.
```
gollum
```
4. 서버 실행후, [http://localhost:4567](http://localhost:4567)로 접속하면 Home화면이 나타난다.
5. 위키페이지를 작성한다.

# custom config 파일 사용방법  

### **Windows**  
1. 위키페이지로 이용되는 repository에 config.rb 파일을 생성한다.
2. config.rb파일에 설정하고자 하는 변수를 설정후 저장한다.
3. gollum 서버 실행시, 다음 명령어를 통해 config 파일 지정 실행을 한다.
```
gollum --config config.rb
```

### **Commit author 설정**
gollum 서버의 default commit author은 Anonymous다. 따라서 commit author를 config 파일을 통해 알려줘야한다.  

* 생성한 config.rb 파일에 다음의 코드를 삽입.
```
# Add in commit user/email
class Precious::App
    before do
        session['gollum.author'] = {
            :name       => `git config --get user.name `.strip,
            :email      => `git config --get user.email `.strip,
        }
    end
end
```
* **gollum 서버 실행시, `gollum --config config.rb`로 실행해야지만 위에 설정한 내용이 적용이 된다.**