# Gollum 설치 방법 (참고 [gollum Github](https://github.com/gollum/gollum/wiki/Installation))

## **Windows**
 
> Warning: Windows support is still in the works! [Many things do not work right now](https://github.com/gollum/gollum/issues/1044), and [many of the tests are currently failing](https://github.com/gollum/gollum/issues/1044#issuecomment-126784479). Proceed at your own risk!

### **설치 환경(작성시점 기준)**  
OS: Windows 10 Home version 1709  
JRuby: 9.1.16.0 Windows Executable (x64)

### **설치 방법** 
gollum 설치에 앞서 우선 [JRuby](http://jruby.org/download)가 설치되어 있어야한다.  
JRuby 설치후, Windows PowerShell을 열어 다음의 명령어를 통해 gollum을 설치한다.
```
~$ gem install gollum
```