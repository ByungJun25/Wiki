# RESTful Web Service

## 1. REST의 이해
**REST**(Representational State Transfer)란 분산시스템 설계를 위한 아키텍쳐 스타일을 말하며 Roy Fielding의 2000년 박사논문에서 소개되고 정의되었습니다. REST는 표준은 아니지만 stateless하다거나, 서버/클라이언트 관계를 가지거나, 일정한 인터페이스를 가지는 것과 같은 **하나의 제약사항**을 나타내는 것입니다. 또한 REST는 엄격하게는 HTTP와 관련이 없지만, 일반적으로 연관이 있다고 말합니다.

## 2. REST의 원칙
* Resource는 URI를 통하여 쉽게 이해할 수 있도록 표현되어야합니다.
* JSON 혹은 XML을 전송하여 data object나 attribute를 나타내야합니다. 
* 메세지는 HTTP method를 이용하여 명시적으로 표현해야합니다. (ex. PUT, GET, POST and DELETE 등)
* Stateless 상호작용이란 각 요청 간 클라이언트의 context가 서버에 저장되지 않음을 말합니다. 

## 3. HTTP methods
HTTP 메소드를 이용하여 CRUD(생성, 검색, 갱신, 삭제) 조작을 HTTP 요청에 매핑합니다.

### 3.1 **GET**
GET 메소드를 이용하여 정보를 검색합니다. GET 요청은 안전해야하고 idempotent해야합니다. 즉, 같은 parameter에 대해 여러번 요청될 수 있어야하며 그 결과는 항상 동일해야합니다. 요청은 부분적일 수도있고 혹은 조건부일수도 있습니다.

  * ID가 1인 주소를 검색하는 요청
```
GET /addresses/1
```

### 3.2 **POST**
POST 메소드는 resource를 요청하고 이를 이용하여 무언가를 하려고할때 사용됩니다. 주로 entity를 생성하거나 혹은 업데이트하는데 사용되어집니다.

  * 새 주소 Entity를 생성하는 요청
```
POST /addresses
```

### 3.3 **PUT**
PUT 메소드는 entity를 저장하기 위해 사용됩니다. PUT메소드는 새 entity를 생성하거나 업데이트하는데 사용될 수도 있습니다. POST와의 차이점은 PUT은 idempotent하다는 것입니다. Idempotency는 PUT을 사용할지 POST를 사용할지 결정하는 주요한 요인입니다. 

  * ID 값이 1인 주소를 변경하는 요청
```
PUT /addresses/1
```

> **Note:** PUT 메소드는 기존에 존재하는 entity를 대체(replace)하는 것입니다. 만약 data elements의 부분집합(subset)만 제공될 경우, rest는 빈 데이터나 혹은 null값으로 대체되어집니다.

### 3.4 **PATCH**
PATCH 메소드는 Entity의 특정 필드의 정보만 업데이트를 하기위해 사용됩니다. PATCH 메소드 또한 idempotent합니다.

  * ID 값이 1인 주소를 업데이트하는 요청
```
PATCH /addresses/1
```

### 3.5 **DELETE**
DELETE 메소드는 resource를 삭제하기위해 사용됩니다. 하지만 리소스는 즉시 삭제될 필요는 없으며, DELETE 요청은 비동기 혹은 장기 요청이 될수도 있습니다.

  * ID 값이 1인 주소를 삭제하는 요청
```
DELETE /addresses/1
```

## 3. HTTP 상태 코드
상태코드는 HTTP 요청의 결과를 나타냅니다.  

* 1XX - 클라이언트의 요청을 서버가 받았음을 말합니다.
* 2XX - 클라이언트의 요청을 서버가 정상적으로 받았고 이를 수행하여 정상적으로 완료했음을 말합니다.
* 3XX - 리다이렉션 완료를 말하며, 클라이언트는 요청을 마치기 위해 추가 동작을 취해야 합니다.
* 4XX - 클라이언트측에 오류가 있음을 말합니다. (ex. 요청이 잘못됨)
* 5XX - 클라이언트의 유효한 요청에 대해 서버가 제대로 수행하지 못했음을 말합니다. 즉, 서버측에 오류가 있음을 말합니다.

## 3. Media 타입
HTTP 헤더의 `Accept` 와 `Contetn-Type`은 HTTP 요청내에서 전송되거나 요청되는 내용을 설명하는데 사용될 수 있습니다. 만약 클라이언트가 JSON으로 응답을 받고자 요청한다면, `Accept`에 `application/json`이라고 설정할 수 있습니다. 반대로 데이터를 전송할때, `Content-Type`에 `application/xml`이라고 설정한다면 이는 클라이언트의 요청이 XML이라는 것을 뜻하게됩니다. 