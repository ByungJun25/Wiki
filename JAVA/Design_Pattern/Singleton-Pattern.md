# Singleton Pattern (싱글톤 패턴)

## 1. 싱글톤 패턴이란?

소프트웨어 디자인 패턴중 생성 패턴에 속하는 디자인 패턴입니다. **Singleton Pattern**을 따르는 클래스는, 생성자가 여러 차례 호출되더라도 실제로 생성되는 객체는 하나이고 최초 생성 이후에 호출된 생성자는 최초의 생성자가 생성한 객체를 리턴합니다. 주로 공통된 객체를 여러개 생성해서 사용하는 DBCP(DataBase Connection Pool)와 같은 상황에서 많이 사용됩니다.  

![Singleton Pattern Class Diagram](https://upload.wikimedia.org/wikipedia/commons/f/fb/Singleton_UML_class_diagram.svg "Singleton Pattern Class Diagram")

* 이미지 출처: 위키백과(<https://ko.wikipedia.org/wiki/%EC%8B%B1%EA%B8%80%ED%84%B4_%ED%8C%A8%ED%84%B4>)

## 2. 싱글톤 구현

### 2.1 Eager initialization
가장 기본적인 singleton pattern으로서 `private static`을 이용하여 클래스 객체를 생성합니다.
```
public class Singleton {
      private static Singleton instance = new Singleton();
      
      private Singleton(){}

      public static Singleton getInstance(){
            return instance;
      }

      ...
}
```
위의 코드는 가장 단순한 singleton pattern 클래스입니다. `static`을 사용하여 `instance`변수를 인스턴스화와 상관없이 사용할 수 있도록하였고, `private` 접근제어자를 이용하여 외부의 직접 접근을 차단하였습니다. 또한 `private`로 정의된 생성자로인해 외부에서는 `new` 키워드를 통한 인스턴스생성이 불가능합니다. 따라서 외부에서는 `getInstance`라는 메소드를 통해서만 Singleton 클래스의 인스턴스를 사용할 수 있습니다.

**위의 코드는 간단하지만 다음의 문제가 있습니다.**

* `new` 키워드때문에 클래스가 로드(load)되는 시점에서 인스턴스를 생성하는데, 리소스가 큰 프로그램에서는 이러한 호출은 부담으로 작용할 수 있습니다. (불필요한 리소스의 낭비를 초래합니다.)
* 클래스가 인스턴스화 되는 시점에 어떠한 에러처리를 할 수 없는 문제가 있습니다.

### 2.2 static block initialization
앞서 말한 `Eager initialization` 코드의 문제점에서 2번째 문제인 **에러처리**문제를 해결하는 코드입니다.
```
public class Singleton {
      private static Singleton instance;
      private Singleton(){}

      static {
            try{
                  instance = new Singleton();
            } catch(Exception e){
                  throw new RuntimeException("Exception creating instance.");
            }
      }

      public static Singleton getInstance(){
            return instance;
      }

      ...
}
```
`static` 초기화 블럭을 이용하여 클래스의 인스턴스를 생성할때 에러처리를 할 수 있도록 한 코드입니다. **하지만 여전히 리소스 낭비의 문제가 존재하고 있습니다.**

### 2.3 lazy initialization
lazy initialization이란 이름그대로 클래스의 인스턴스를 미리 생성하지 않고, 클래스 인스턴스가 사용되는 시점에 인스턴스를 만들도록하는 Singleton pattern 코드입니다.
```
public class Singleton {
    private static Singleton instance;

    private Singleton(){}
    
    public static Singleton getInstance(){
    	if(instance == null) {
    		instance = new Singleton();
    	}
        return instance;
    }
    
    ...
}
```
위의 코드를 보면 `getInstance`메소드에서 instance 변수가 null인 경우만 `new` 키워드를 이용하여 인스턴스를 생성함을 알 수 있습니다. 최초 사용시점에만 인스턴스화를 하기때문에 `Eager initialization` 코드의 메모리 낭비 문제를 해결할 수 있습니다. 하지만 lazy initialization 코드는 **multi thread방식에서는 안전하지 않다는 문제점이 있습니다.** multi thread에서는 동일한 시점에 `getInstance`메소드가 호출될 수 있으며, 이렇게 될 경우 2개의 인스턴스가 생길 수 있습니다.

### 2.4 synchronized 키워드를 통한 initialization
앞서 봤던 lazy initialization 코드는 multi thread에서는 안전하지 않다고 하였습니다. 그렇다면 multi thread에서 안전하려면 어떻게 해야할까요? 우선 가장 간단한 방법은 `synchronized` 키워드를 사용하는 것입니다. `synchronized` 키워드가 선언되어져 있으면 그 블록은 한 시점에 한 쓰레드만이 블록 안으로의 접근이 허용되기 때문입니다.
```
public class Singleton {
    private static Singleton instance;

    private Singleton(){}
    
    public static synchronized Singleton getInstance(){
    	if(instance == null) {
    		instance = new Singleton();
    	}
        return instance;
    }
    
    ...
}
```
하지만 위의 코드는 `synchronized` 키워드가 `getInstance`라는 메소드에 선언되어져 있습니다. **따라서 `getInstance` 메소드로 수많은 접근 요청이 들어올 경우, 속도 저하의 성능 문제가 발생할 수 있습니다.**

### 2.5 DCL(Double-checking Locking) initialization
앞서 봤던 synchronized 키워드를 통한 initialization 코드는 `synchronized` 키워드로 인해 속도 저하의 문제가 발생할 수 있었습니다. 따라서 이러한 속도저하 문제를 해결하기위해 DCL 방법이 등장하였습니다. 아래는 DCL방법을 이용한 Singleton pattern 코드입니다.
```
public class Singleton {
    private static Singleton instance;

    private Singleton(){}
    
    public static Singleton getInstance(){    	
    	if(instance == null) {
    	    synchronized (Singleton.class) {
		if(instance == null) {
		    instance = new Singleton();
		}
	    }
    	}
        return instance;
    }
    
    ...
}
```
위의 코드를 보면 알 수 있듯이, DCL은 이름 그대로 인스턴스의 존재를 두번 확인하는 방법입니다. 위의 코드를 보면 현재 `getInstance` 메소드에는 `synchronized` 키워드가 붙어있지 않습니다. 따라서 외부에서 `getInstance`의 접근 요청은 그대로 모두 받아들이게 됩니다. 그리고 이후 instance 변수의 null 여부를 먼저 확인하게되는데 instance 변수가 null이 아닐경우에는 바로 instance값을 반환하기때문에 `getInstance`메소드 호출시의 성능저하 문제가 발생하지 않습니다. 이 방법은 코드만 볼 경우 매우 효율적인 코드라고 생각할 수 있습니다. **하지만 이 코드는 memory를 공유하여 사용하는 경우에 다음과 같은 문제가 발생할 수 있습니다.**

`Thread A`와 `Thread B`가 있을때, 두개의 쓰레드가 동시에 `getInstance`로 진입하게되고, `Thread A`가 먼저 동기화 블록으로 진입하였다고 생각하겠습니다. 이 경우 `Thread A`는 새로운 인스턴스 생성을 위해 메모리 공간을 할당합니다. 그리고 이렇게 메모리가 할당된 순간 `Thread B`는 이 메모리에 접근(첫번째 `if` 부분)을 시도합니다. `Thread A`에 의해 메모리는 이미 할당되었기에 `Thread B`는 `Thread A`가 instance의 생성을 마치기 전에 메모리에 접근이 가능하게됩니다. 즉 `Thread B`는 `Thread A` 가 인스턴스를 생성하지 않았음에도 불구하고 메모리에 접근하는 정상적이지 못한 행동을 하게되는 것입니다. 물론 이러한 경우가 발생할 확률은 적겠지만, '가능성이 있다'라는 것은 '가능성이 없다'와는 엄청난 차이이기에 위의 코드는 현재 사용이 권유되고 있지 않습니다.

### 2.6 initialization on demand holder idiom
initialization on demand holder idiom 기법은 미국 메릴랜드 대학의 컴퓨터 과학 연구원인 Bill pugh가 제시한 방법으로서 `JVM`의 class loader의 매커니즘과 class의 load 시점을 이용한 방법입니다. 이 방법은 `synchronized` 키워드 없이 thread간의 동기화 문제를 해결한 아주 좋은 코드라고 할 수 있습니다. 뒤에 나올 `enum`을 이용한 방법과 같이 singleton pattern 구현을 위해 현재 많이 사용되고 있는 코드입니다.
```
public class Singleton {
    private Singleton(){}
    
    public static Singleton getInstance(){    	
    	return SingletonLazyHolder.INSTANCE;
    }
    
    private static class SingletonLazyHolder {
    	private static final Singleton INSTANCE = new Singleton();    	
    }
    
    ...
}
```
위의 코드를 살펴보도록 하겠습니다. `Singleton`클래스는 내부 클래스인 `SingletonLazyHolder`클래스의 변수를 가지고 있지 않기 때문에 `Singleton`클래스 로딩시 `SingletonLazyHolder`클래스를 초기화하지 않습니다. `Singleton` 클래스의 `getInstance`메소드가 호출되고 `SingletonLazyHolder`클래스의 `INSTANCE` 변수에 접근하는 순간, `SingletonLazyHolder`클래스의 초기화가 진행되게 됩니다. 클래스 초기화는 JVM에 의해 이루어지기 때문에, **JVM의 원자적특성을 이용하게되고 이를 통해 thread-safe가 보장되게됩니다.** 또한 위의 코드는 **모든 java 버전과 JVM에서 사용이 가능하다는 이점**도 가지고 있습니다.

### 2.7 Enum 을 이용한 initialization
이 방법은 말그대로 `class`가 아닌 `enum`으로 정의하는 방법입니다. `enum`은 인스턴스의 생성과 상속을 방지하고 상수값의 타입안정성을 보장합니다.(단, `enum`은 JDK1.5 이후부터 사용가능합니다.) 따라서 다음과 같은 코드를 통해 Singleton pattern을 구현할 수 있습니다.
```
public enum Singleton {
    INSTANCE;

    ...
}

public class Demo {
    Singleton singleton = Singleton.INSTANCE;

    ...
}
```
위의 방법을 통해 Singleton을 구현할 경우 다음과 같은 이점이 있습니다.

* `INSTANCE`가 생성될때, multi thread로부터 안전합니다.(하지만, 내부 메소드는 thread-safe가 보장되지 않습니다.)
* 직렬화가 자동으로 처리되고 직렬화가 아무리 복잡하게 이루어져도 여러 객체가 생길일이 없습니다.
* 리플렉션(Reflection)을 통한 싱글톤 깨트림을 시도할 수 없습니다.
  * 앞서 봐왔던 코드에서 private로 생성자를 선언하였지만, runtime에서 리플렉션(Reflection)을 통해 private 생성자에 접근을 할 수 있기때문에 싱글톤 깨트림 문제가 발생할 수 있습니다.

`enum`을 사용한 singleton은 여러 문제를 한번에 해결할뿐만 아니라 인스턴스 생성에 대한 thread-safe까지 보장되기에 **effective java에서 추천하는 방법**입니다. 다만 기존 `enum`을 사용하던 방식과 다르기에 일반적인 쓰임새와 혼동되지 않도록 주의해야할 필요가 있습니다.


## 참고 사이트

* <https://ko.wikipedia.org/wiki/%EC%8B%B1%EA%B8%80%ED%84%B4_%ED%8C%A8%ED%84%B4>
* [http://jdm.kr/blog/10](http://jdm.kr/blog/10)