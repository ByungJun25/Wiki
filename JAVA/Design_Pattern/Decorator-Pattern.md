# Decorator Pattern (데코레이터 패턴)

## 1. 데코레이터 패턴이란?

소프트웨어 디자인 패턴중 구조 패턴에 속하는 디자인 패턴입니다. **Decorator Pattern**은 주어진 상황 및 용도에 따라 어떤 객체에 기능을 동적으로 덧붙이는 패턴으로, 서브 클래스를 이용해 기능을 유연하게 확장할 수 있습니다.

![데코레이터 패턴](https://raw.githubusercontent.com/ByungJun25/Wiki/master/resource/images/decorator_pattern_diagram.png)

## 2. 데코레이터 패턴 구현

### 2.1 Component Interface(or Abstract Class)
```
public interface Component {
      public void method();
      ...
}
```

### 2.2 ConcreteComponent Class
```
public class ConcreteComponent implements Component {
      @Override
      public void method() {
             ...
      }
      ...
}
```

### 2.3 Decorator Abstract Class
```
public abstract class Decorator implements Component {
      protected Component component;

      public Decorator(Component component) {
             this.component = component;
      }

      @Override
      public abstract void method();
      ...
}
```

### 2.4 ConcreteDecorator Class
```
public class ConcreteDecorator extends Decorator {

      public ConcreteDecorator(Component component) {
             super(component);
      }

      @Override
      public void method() {
             //이곳에 component.method()를 확장한 기능으로 정의하면 됩니다. 
             //기존의 component를 파라미터로 가지고 있기에 이를 활용할 수 있습니다.
             ...
      }
      ...
}
```

### 2.5 사용 예제
```
public class MainTestClass {
      public static void main(String[] args) {
             Component component = new ConcreteComponent();
             
             component = new ConcreteDecorator(component);

             component.method(); //ConcreteDecorator의 method가 호출됩니다.
      }
      ...
}
```

## 3. 정리
데코레이터 패턴의 대표적인 예로는 자바 API의 파일 I/O가 있습니다. 데코레이터 패턴을 이용하면 기존 클래스의 변경없이 유연하게 기능을 확장할 수 있게됩니다. 하지만 각각의 데코레이터 클래스를 구현해야하기 때문에 각 데코레이터 클래스의 역할을 확실히 알고 있어야 합니다. 따라서 너무 많은 데코레이터 클래스가 생기지 않도록 적절한 위치에 데코레이터 패턴을 활용해야합니다.

## 참고 사이트

* <https://ko.wikipedia.org/wiki/%EB%8D%B0%EC%BD%94%EB%A0%88%EC%9D%B4%ED%84%B0_%ED%8C%A8%ED%84%B4>
* <http://jdm.kr/blog/78>
* <http://jusungpark.tistory.com/9>