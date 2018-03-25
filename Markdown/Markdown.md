# Markdown (마크다운)

## 1. Markdown에 대해

### 1.1 Markdown이란?
**Markdown**은 일반 텍스트 문서의 양식을 편집하는 문법으로서 **존그루버**에 의해 2004년에 만들어졌습니다.  
Markdown의 목표는 플레인 텍스트 포맷을 사용하여 사용자들이 보다 쉽고 편리하게 텍스트 문서를 작성할 수 있도록하고,  
XHTML 이나 HTML로 선택적 변환이 가능하게 하는 것입니다. 대표적인 마크다운 문법으로 작성된 텍스트 문서는 [Github](https://github.com/)의 README.md 파일입니다. 

## 2. Markdown 사용법


### 2.1 머리말 (Header)
* Header는 H1~H6까지 지원하며 H1 과 H2는 자동으로 밑줄이 그어집니다. 문법은 아래와 같습니다. [(예제)](https://github.com/ByungJun25/Wiki/blob/master/Markdown/Example.md#%EB%A8%B8%EB%A6%AC%EB%A7%90-header)
```
# H1 입니다.
## H2 입니다.
### H3 입니다.
#### H4 입니다.
##### H5 입니다.
###### H6 입니다.
```

### 2.2 수평선 (Horizon)
* hr이라고 하는 수평서는 주로 페이지를 나누는 용도로 많이 사용되어집니다.  
문법은 아래와 같습니다. 무엇을 사용하든 동일한 수평선을 만듭니다. [(예제)](https://github.com/ByungJun25/Wiki/blob/master/Markdown/Example.md#%EC%88%98%ED%8F%89%EC%84%A0-horizon)
```
---
***
___
```

* H1 과 H2를 위한 수평선 문법이 따로 존재합니다. 주로 명시적으로 수평선을 표시하기 위해 사용됩니다.  
문법은 아래와 같습니다.
```
이것은 H1수평선 예제입니다.
=========================

이것은 H2수평선 예제입니다.
-------------------------
```

### 2.3 개행(New line)
+ Markdown에서 개행은 두가지 방식있습니다.
  - 강제개행: 문장의 마지막에 공백(`  `)을 두번 입력합니다.
  - 단락바꿈: `Enter`키를 두번 입력합니다.
* 문법은 아래와 같습니다. [(예제)](https://github.com/ByungJun25/Wiki/blob/master/Markdown/Example.md#%EA%B0%9C%ED%96%89new-line)
```
강제개행 문법입니다.  
문장끝의 공백을 통해 개행이 적용됩니다.

단락바꿈 문법입니다.

Enter키를 통해 개행이 적용됩니다.
```

### 2.4 인용구 (BlockQuote)
* Markdown 문법에서도 HMTL에서의 `<bkockquote>`태그인 인용구가 존재합니다. 문법은 아래와 같습니다. [(예제)](https://github.com/ByungJun25/Wiki/blob/master/Markdown/Example.md#%EC%9D%B8%EC%9A%A9%EA%B5%AC-blockquote)
```
> 인용구입니다.
>>인용구안에 인용구를 사용할 수 있습니다.
```

### 2.5 목록 (List)
* HTML의 `ul` , `ol` 에 대응하는 리스트문법입니다. 문법은 아래와 같습니다. [(예제)](https://github.com/ByungJun25/Wiki/blob/master/Markdown/Example.md#%EB%AA%A9%EB%A1%9D-list)
```
순서가 없는 리스트입니다.
* 리스트1
* 리스트2
* 리스트3

순서가 있는 리스트입니다.
1. 리스트1
2. 리스트2
3. 리스트3
```
* 서브 리스트 또한 만들수 있으며 다음의 문법을 사용합니다.(꼭 **들여쓰기**를 하여야합니다.) [(예제)](https://github.com/ByungJun25/Wiki/blob/master/Markdown/Example.md#%EB%AA%A9%EB%A1%9D-list)
```
* 상위 리스트1
  * 하위 리스트1
  * 하위 리스트2
    * 하위의 하위 리스트1
    * 하위의 하위 리스트2
```
* 또한 리스트 생성시 `*` 외에 `+` , `-` 를 이용할수도 있습니다. [(예제)](https://github.com/ByungJun25/Wiki/blob/master/Markdown/Example.md#%EB%AA%A9%EB%A1%9D-list)
```
* 라스트
+ 리스트
- 리스트 
```

### 2.4 코드 (Code)
* HTML의 `<code>` 태그에 대응하는 문법입니다. 문법은 아래와 같습니다. [(예제)](https://github.com/ByungJun25/Wiki/blob/master/Markdown/Example.md#%EC%BD%94%EB%93%9C-code)
```
문장속에 코드를 넣고 싶으면 문장중에 `(내용)` 을 넣으시면 됩니다.

코드부분만 따로 박스처리하고 싶으시다면,
 ```
  (내용)
 ```
위와 같은 방법을 이용하시면 됩니다.
```

### 2.6 링크 (Link)
* HTML의 `<link>` 태그에 대응하는 문법입니다.  
크게 2가지의 방법이 있으며, 문법은 다음과 같습니다. [(예제)](https://github.com/ByungJun25/Wiki/blob/master/Markdown/Example.md#%EB%A7%81%ED%81%AC)
```
URL주소를 바로 링크로 만들고 싶으면 <링크주소> 를 사용하면 됩니다.

URL주소에 임의의 링크텍스트를 사용하고 싶으묜 [텍스트](링크주소) 를 사용하면 됩니다.
```

### 2.7 강조
* 텍스트를 강조하고 싶을때 사용하는 문법입니다. 문법은 아래와 같습니다. [(예제)](https://github.com/ByungJun25/Wiki/blob/master/Markdown/Example.md#%EA%B0%95%EC%A1%B0)
```
**강조할 텍스트**
```

### 2.8 이미지 (Image)
* HTML의 `<img>` 태그에 대응하는 문법입니다. 문법은 아래와 같습니다. [(예제)](https://github.com/ByungJun25/Wiki/blob/master/Markdown/Example.md#%EC%9D%B4%EB%AF%B8%EC%A7%80)
```
![Alt text](파일경로)
![Alt text](파일경로 "title")
```

## 참고 사이트
* <https://gist.github.com/ihoneymon/652be052a0727ad59601>
* <https://gist.github.com/ninanung>