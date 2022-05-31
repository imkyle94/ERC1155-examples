# ERC1155-examples
기업 협약 프로젝트에서 구현했던 ERC721 컨트랙트를 ERC1155 로 마이그레이션하며 알게된 내용과 그 예제를 작성합니다
추가적으로, ERC 오픈 소스를 사용하며 참고하면 좋을 내용 역시 작성하였습니다.

### ERC721 -> ERC1155
0. ERC 공부하는 법
-> openzeppelin Docs와 Github examples 를 동시에 보는 것을 추천합니다. 공식 문서에서 약간 모호한 내용들이 있습니다. 그 경우에 공식 깃허브에 적혀있는 컨트랙트를 보면 도움이 많이 될 것 입니다.
[OpenZepplin ERC1155 API](https://docs.openzeppelin.com/contracts/4.x/api/token/erc1155)
[OpenZepplin Contracts Githhub](https://github.com/OpenZeppelin/openzeppelin-contracts)

1. ERC는 크게 코어(Core) 코드와 확장(Extension) 코드로 나뉘어져 있습니다. 성격에 맞게 메서드들이 구현되어 있는데, 본인이 작성할 컨텐츠에 맞게 각 코드를 적절히 취사선택하면 됩니다. 코드의 구조는 본인 입맛에 따라 다양하게 작성할 수 있습니다.

2. Override
-> 일반적으로는 하나의 컨트랙트를 상속하거나, 두 개의 컨트랙트를 동시에 상속하거나(ex. ERC1155, ERC1155URIStorage) 하는 경우입니다.
-> 다른 방법으로는 컨트랙트를 각자 운영하거나, 인스턴스를 내는 경우일텐데, 개인적으로 상속이 가장 효율적이지 않나 생각합니다.
-> 이 때, 상속시키는 부모 컨트랙트에 동일한 메서드가 존재할 경우, 이를 오버라이딩하는 행위가 필요합니다.
-> 깃허브 코드에 이를 명시하고 있습니다.
-> 예제에 구현되어 있습니다.
-> ERC1155에서 실제로 오버라이딩한 메서드를 나열합니다.
-> function _beforeTokenTransfer(
    address operator,
    address from,
    address to,
    uint256[] memory ids,
    uint256[] memory amounts,
    bytes memory data
  ) internal virtual override(ERC1155, ERC1155Supply) {
    super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
  }
  
->   function uri(uint256 tokenId)
    public
    view
    virtual
    override(ERC1155, ERC1155URIStorage)
    returns (string memory)
  {
    // string memory tokenURI = _tokenURIs[tokenId];
    // If token URI is set, concatenate base URI and tokenURI (via abi.encodePacked).
    // return bytes(tokenURI).length > 0 ? string(abi.encodePacked(_baseURI, tokenURI)) : super.uri(tokenId);
  }


### ERC721과 ERC1155의 변경점
- 아무래도 대체불가 토큰 ERC721과 다시 ERC20를 결합해서 탄생한 ERC1155 사이에 약간의 차이점이 존재합니다.
- 제가 적은 내용 외에도 다양한 차이점이 존재합니다. ERC721 -> ERC1155의 방향성을 파악하는 것이 중요하겠습니다.
- constructor() 매개변수가 변경되었습니다.
- _exists에서 exists로 함수가 변경되었습니다.
- 민팅(Mint) 매개변수가 변경되었습니다.
- 
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

### ERC와 ERC extension의 차이는 무엇인가요?
공식 문서보다 깃허브 코드를 보는 것이 더 직관적일 듯하다.
[openzeppelin-contracts](https://github.com/OpenZeppelin/openzeppelin-contracts)
extension에서 코드의 변경점들을 확인할 수 있다.
다양한 허브들이 제시되고 있으니 꼭 확인할 것!

### Interface의 중요성

###
나 저 사람에 대한 정보를 알고 싶어요. 라고 한다면,
그래 그 사람 이름 알아와서 너가 적어 알아봐줄게. 가 가장 낮은 단계일 것이고
누구 쟤? 라고 지시를 해주는 것이 결국엔 서비스고 API라는 것이 내 생각이다.

### API?
API를 하나 개발한다고 가정을 해보자
원체 가진것도 많고 아는 것도 많아서 순도 100%를 다 내 선에서 처리를 한다면 정말 좋겠지만, 현실의 벽이 있어
OPEN API도 가져와 개발을 한다고 해보자.
데이터를 가져오는 방법은, 지역변수, 전역변

### Data Location

블록체인(이더리움 네트워크, 블록체인 네트워크 등 이하 통칭) 내에서 데이터들의 위치를 선정한다면, 다음의 경우를 제시할 수 있다.

1. state or 
2. Pool, 공간을 제시하기

그렇다면, 각각의 경우에 데이터를 접근하는 방법은 어떠한 것이 있는지 고려해본다.



이들을 찾거나 하는 등의 쿼리를 작성할 때 가장 쉬운 방법은 역시 indexing 일 것이다.

### ERC721
erc721 : 대체 불가능한 토큰을 만드는 과정에서 어떠한 기능이 필요할까 생각해보자.

NFT를 만드는 서비스라고 해보자.

1. 민팅
=> 민팅을 해서 데이터가 나왔다면,
데이터들이 서로가 구분이 되어야 할 것.
데이터들은 어떠한 규칙으로 개성을 부여할 것인가?
=> 번호 : 인덱싱, 이름 : 맵핑 + 이넘
=> 이름은 어떤 이름? : tokenURI
=> 이름도 이름나름의 규칙이 있어야지, 정호 민수 성현이 이딴 식이면 효율적인 방안이 아니다.

가장 효율적인 방안을 개인적인 의견으로는,
인덱싱 번호 부여 => 인덱싱이 부여 된 것을 로컬 DB에 저장 => 추가적으로 인덱싱 번호와 내 캐릭터를 연결하는 로직 구현

그리고 만들어진 데이터들을 쉽게 검색이 가능해야 할 것.
데이터의 소각이 가능할 것?

### 결합도를 중심으로 데이터베이스와 이더리움 네트워크 스토리지를 비교하기


### 이더를 보내는 상황을 가정하자.
이더를 보낸다고 상황을 가정하면 필요한 변수는 (보내는이, 받는이, 금액) 정도일 것이다.
이 때 send, call, transfer 등의 메서드를 컨트랙트 내에 구현해놓을 수도 있고, 클라이언트(web3)에서 바로 적어줄 수도 있다.
둘의 차이점을 제시해본다면.

1. 변수를 컨트랙트로 숨기는 것이 아니라 수면 위로 올리는 행위가 보안 등에서 안전한가?
-> 해킹을 당한다. 해킹이 코드 속으로 들어오는 것인가?
