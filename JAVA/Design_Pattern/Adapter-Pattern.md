# Adapter Pattern (어댑터 패턴)

## 1. 어댑터 패턴이란?

소프트웨어 디자인 패턴중 구조 패턴에 속하는 디자인 패턴입니다. **Adapter Pattern**은 클래스의 인터페이스를 사용자가 기대하는 다른 인터페이스로 변환하는 패턴으로, 호환성이 없는 인터페이스 때문에 함께 동작할 수 없는 클래스들이 함께 작동하도록 해줍니다. 주로 기존 클래스의 소스 코드를 수정하지 않고 다른 사용자와 함께 사용하는데 자주 사용됩니다. 대표적인 예로는 XML 문서의 Document Object Model 인터페이스를 나타낼 수 있는(can be displayed) 트리 구조로 변환하는 어댑터가 있습니다.  

## 2. 어댑터 패턴의 종류

어댑터 패턴은 크게 다음의 두가지로 분류됩니다.

* 객체 어댑터 패턴 - 위임을 이용한 어댑터 패턴


![객체 어댑터 패턴](https://raw.githubusercontent.com/ByungJun25/Wiki/master/resource/images/instance_adapter_diagram.png)

* 클래스 어댑터 패턴 - 상속을 이용한 어댑터 패턴


![클래스 어댑터 패턴](https://raw.githubusercontent.com/ByungJun25/Wiki/master/resource/images/class_adapter_diagram.png)

## 3. 어댑터 패턴의 구현

**구현 예시는 객체 어댑터 패턴을 사용합니다.**

* Client Class
```
public class Client {
	public void main(){		
		Adaptee adaptee = new Adaptee();
		Target target = new Adapter(adaptee);
		target.method();
		...
	}
}
```

* Target Interface
```
public interface Target {
	public void method();
	...
}
```

* Adapter Class
```
public class Adapter implements Target {
	private Adaptee adaptee;
	
	public Adapter(Adaptee adaptee) {
		this.adaptee = adaptee;
	}

	@Override
	public void method() {
		this.adaptee.specific_method();		
	}
	
	...
}
```

* Adaptee Class
```
public class Adaptee {
	public void specific_method(){
		...
	}
}
```

## 4. 어댑터 패턴의 사용 이유
어댑터 패턴을 사용하는 이유는 무엇일까요? 그리고 언제 이 패턴을 적용해야할까요?
우선 다음의 상황을 보도록 하죠.
```
한국에 살던 철수는 일본으로 넘어가 생활해야할 상황이 생겼습니다.
그리고 철수는 220V인 가전용품을 모두 들고 일본에 가서 사용하길 바랍니다.
하지만 일본은 110V를 사용하기때문에 철수는 다음의 두가지의 선택을 고를 수 있습니다.

1. 일본에 있는 집의 모든 110V의 콘센트를 220V의 콘센트로 변경한다.
2. 110V 어댑터를 사서 이용한다.
```

위와 같은 상황일 경우, 보통 경제적 효율성을 고려하여 2번을 선택하게 될것입니다. 물론 1번을 선택하여 모두 고칠수도 있지만, 그건 배보다 배꼽이 더 큰 경우라고 할 수 있습니다. 왜냐하면 모든 콘센트를 바꾼다는것은 집도 손을 봐야한다는 것이기때문에 모든 콘센트를 변경할바에야 새로 가전용품을 사는게 더 경제적이기 때문입니다. 

그럼 이제 이 예시를 그대로 프로그램 유지보수라는 측면에 적용해보도록 하겠습니다.  
다음과 같이 매칭을 시킬수 있을것입니다.

```
* 철수 - 클라이언트
* 일본으로 이사 - 보다 좋은 라이브러리로 변경 요청
* 220V 가전제품 - 새 라이브러리
* 집 - 메인 로직
* 110V 콘센트 - 기존 라이브러리
```
이제 약간 감이 잡히시는가요? 유지보수 측면에서 기존의 로직을 수정한다는 것은 엄청난 비용을 초래할 뿐만 아니라 엄청나게 위험한 행동이기도 합니다. (막무가내 수정을 한다면 상급자로부터 따귀를 맞을지도 모릅니다.) 따라서 이러한 문제를 해결하기위해 어댑터 패턴이 등장하였습니다. 기존 로직의 수정없이 새 코드를 효율적으로 사용할 수 있기 때문이죠. 

## 5. 어댑터 패턴 예제
우리는 프로그래머이니 이제 코드를 통해 이해해보도록 하겠습니다.
```
public class Client {
	/*메인 로직*/
	public void createDocument(){
		OriginLib lib = new OriginLib();
		Document document = lib.createEmptyDocument();
		lib.insertHead(document);
		lib.insertText(document);
		lib.insertCopyright(document);
	}
}
```
예시로 위와 같이 문서를 만들어주는 프로그램이 있다고 가정하겠습니다. 이 프로그램의 메인 로직은 빈 문서를 생성하여 헤드, 텍스트 그리고 마지막으로 카피라이트를 넣는다고 하겠습니다. 기존에 사용하던 라이브러리는 `OriginLib` 라이브러리이고 여기서 `insertCopyright`메소드는 "텍스트+이미지"를 넣는 메소드라고 가정하겠습니다.  

이제 클라이언트가 성능이 더 좋은 새로운 라이브러리를 발견하고 라이브러리 변경을 요청하였습니다.  
새로운 라이브러리는 다음과 같습니다.
```
public class NewLib {
	public Document createEmptyDocument(){...};
	public void insertHead(document){...};
	public void insertText(document){...};
        public void insertImage(document){...};
}
```
아쉽게도 새 라이브러리는 성능은 더 좋지만 카피라이트를 넣어주는 기능은 없는 상황입니다. 대신 `insertImage`라는 이미지를 넣어주는 메소드가 존재합니다. 그렇다면 우리는 어떻게 코드를 변경해야할까요?
```
public class Client {
	/*메인 로직*/
	public void createDocument(){
		NewLib lib = new NewLib();
		Document document = lib.createEmptyDocument();
		lib.insertHead(document);
		lib.insertText(document);
		lib.insertText(document);
                lib.insertImage(document);
	}
}
```
이렇게 수정해보도록 하겠습니다. 새 라이브러리는 `insertCopyright` 메소드가 없으므로 copyright를 만들기위해 `insertText` 메소드를 한번 더 호출하고 `insertImage`를 호출하여 copyright를 만들었다고 하겠습니다. 이제 프로그램은 정상적으로 작동하고 클라이언트는 만족해하며 돌아갔습니다.

그럼 여기서 한가지 질문을 해보도록 하겠습니다. 과연 저렇게 수정해도 괜찮을까요? 유지 보수측면에서 문제가 없을까요? 
만약 클라이언트가 다시 돌아와 기존 라이브러리로 사용해달라고 재요청을 하거나 또 다른 새로운 라이브러리를 들고온다면 우리는 어떻게 해야할까요? 위와 같은 경우 분명 우리는 다시 메인 로직을 수정해야할 것입니다. 따라서 이처럼 메인로직을 수정한다는 것은 많은 비용이 드는 유지 보수라고 할 수 있습니다. 그렇다면 다시 코드를 수정해보도록하죠. 이번에는 어댑터 패턴을 이용해 수정해보도록 하겠습니다.

* Interface
```
public interface DocumentLib {
	public Document createEmptyDocument();
	public void insertHead(document);
	public void insertText(document);
	public void insertCopyright(document);
}
```

* Adapter Class
```
public class NewLibAdapter implements DocumentLib {
	private NewLib lib;
	
	public NewLibAdapter(NewLib lib) {
		this.lib = lib;
	}

	public Document createEmptyDocument(){
		return lib.createEmptyDocument();
	};
	public void insertHead(document){
		lib.insertHead(document)
	};
	public void insertText(document){
		lib.insertText(document)
	};
	public void insertCopyright(document){
		lib.insertText(document);
		lib.insertImage(document);
	};
	
	...
}
```
* main 로직
```
public class Client {
	/*메인 로직*/
	public void createDocument(){
		NewLib newLib = new NewLib();
                DocumentLib lib = new NewLibAdapter(newLib);
		
                lib.createEmptyDocument();
		lib.insertHead();
		lib.insertText();
		lib.insertCopyright();
	}
}
```
자 이제 다시 메인로직을 보도록하죠. 현재 메인로직에는 라이브러리 선언부분이 변경되고 어댑터를 호출하는 부분이 추가되었지만 그외 문서를 만드는 로직 자체는 변경되지 않았습니다. 이처럼 어댑터 패턴을 활용하게 될 경우, 시스템의 메인 로직의 변경없이 새로운 코드를 가져다 쓸 수 있게됩니다. 또한 차후 새로운 요청사항(기존 라이브러리로 변경 혹은 새 라이브러리 변경 등)이 들어와도 메인 로직의 수정이 필요하지 않게됩니다. 위의 메인 로직을 수정하던 경우와 비교하였을때, Adapter Pattern을 이용하면 상당히 많은 비용을 절감할 수 있다는 것을 알 수 있습니다. 따라서 유지보수시에 적절하게 Adapter Pattern을 이용한다면 보다 효율적인 유지보수가 가능할 것입니다.

## 참고 사이트

* <https://en.wikipedia.org/wiki/Adapter_pattern>
* <http://jdm.kr/blog/11>
* <http://iilii.egloos.com/3789009>