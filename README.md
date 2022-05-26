# ERC1155-examples
ERC1155 사용 예제를 제공합니다.

###
나의 경우 블록체인 코어 & 메인넷 개발자를 목표로 하고 있기 때문에(코인 발행에 당당히 내 이름을 넣고 싶다.)

### ERC ?
Ethereum-Request for Comment 인데 단어 자체를 꼭 이해할 필요는 없을 거 같고, 이더리움 내의 인터페이스 혹은 메서드 정도라고만 이해해도 될 듯 하다.

### ERC vs IERC ?
IERC is the Interface for the token contract.
ERC is the implementation of the token contract.

약간의 설명을 붙여본다. 면접 질문이나, 혹은 현업에서 가장 자주 마주치게 되는 단어를 꼽으라한다면 당연지사 API일 것이다.

API, SDK(순대국 아님), JSON-RPC 등 일맥상통하는 내용이기 때문에 이 부분을 공통적으로 요하는 개념을 잘 익히는 것이 매우 중요할 듯 하다.

Interface를 굳이 왜 따로 제시하냐에 대한 질문에는 다음과 같이 답을 해볼 수 있다.

골격을 만드는 것이 굉장히 어려울 듯 하다.
골격을 제시하면, 먼저 발언하면 거기에 살 붙이는 건 굉장히 쉬운 과정이고, 효율적이기 때문이다.


그렇다면 다음 내용을 좀 더 이어가 본다.


### Data Location

블록체인(이더리움 네트워크, 블록체인 네트워크 등 이하 통칭) 내에서 데이터들의 위치를 선정한다면, 다음의 경우를 제시할 수 있다.

1. state or 
2. Pool, 공간을 제시하기

그렇다면, 각각의 경우에 데이터를 접근하는 방법은 어떠한 것이 있는지 고려해본다.



이들을 찾거나 하는 등의 쿼리를 작성할 때 가장 쉬운 방법은 역시 indexing 일 것이다.
