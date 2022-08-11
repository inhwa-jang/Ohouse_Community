<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">게시판 조회</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">게시글 조회 페이지</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
					<div class="form-group">
						<label>글 번호</label>
						<input class="form-control" name="bno" value='<c:out value="${board.bno }"/>' readonly="readonly">
					</div>
					<div class="form-group">
						<label>작성자</label>
						<input class="form-control" name="writer" value='<c:out value="${board.writer }"/>' readonly="readonly">
					</div>
					<div class="form-group">
						<label>제목</label>
						<input class="form-control" name="title" value='<c:out value="${board.title }"/>' readonly="readonly">
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea class="form-control" rows="10" name="content" readonly="readonly"><c:out value="${board.content}"/></textarea>
					</div>
					
					<button data-oper='modify' class="btn btn-default">수정</button>
					<button data-oper='list' class="btn btn-info">목록</button>
					
					<!-- operForm 시작 -->
					<form id='operForm' action="/board/modify" method="get">
						<input type='hidden' id='bno' name='bno' value='<c:out value="${board.bno}"/>'>
						<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>
						<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
						
						<!-- Criteria의 키워드와 타입에 대한 처리 시작 -->
						<input type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
						<input type='hidden' name='type' value='<c:out value="${cri.type}"/>'> 
						<!-- Criteria의 키워드와 타입에 대한 처리 종료 -->
					</form>
					<!-- operForm 종료 -->
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->

<!-- 댓글 목록 표시 영역 시작 -->

<div class='row'>

  <div class="col-lg-12">

    <!-- /.panel -->
    <div class="panel panel-default">
      <div class="panel-heading">
        <i class="fa fa-comments fa-fw"></i> 댓글 목록
        <button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>댓글 작성</button>
      </div>
      
      <!-- /.panel-heading -->
      <div class="panel-body">
      
        <ul class="chat">

        </ul>
        <!-- ./ end ul -->
      </div>
      <!-- /.panel .chat-panel -->

	<div class="panel-footer"></div>


		</div>
  </div>
  <!-- ./ end row -->
</div>

<!-- 댓글 목록 표시 영역 끝 -->

</div>

<!-- 모달 추가 시작 -->
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
            <div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
              <h4 class="modal-title" id="myModalLabel">댓글 등록</h4>
            </div>
            <div class="modal-body">
            	<div class="form-group">
					<label>작성자</label> 
					<input class="form-control" name='replyer' value='replyer'>
				</div>
				<div class="form-group">
					<label>내용</label> 
					<input class="form-control" name='reply' value='New Reply!!!!'>
				</div>      
				<div class="form-group">
					<label>일자</label> 
					<input class="form-control" name='replyDate' value='2018-01-01 13:13'>
				</div>
            </div>
			<div class="modal-footer">
		        <button id='modalModBtn' type="button" class="btn btn-warning">수정</button>
		        <button id='modalRemoveBtn' type="button" class="btn btn-danger">삭제</button>
		        <button id='modalRegisterBtn' type="button" class="btn btn-primary">등록</button>
		        <button id='modalCloseBtn' type="button" class="btn btn-default">닫기</button>
			</div>          
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<!-- 모달 추가 끝 -->

<script type="text/javascript">
$(document).ready(function() {

  var operForm = $("#operForm"); 

  $("button[data-oper='modify']").on("click", function(e){

    operForm.attr("action","/board/modify").submit();

  });

  $("button[data-oper='list']").on("click", function(e){

    operForm.find("#bno").remove();
    operForm.attr("action","/board/list")
    operForm.submit();

  });
});
</script>

<script type="text/javascript" src="/resources/js/reply.js"></script>

<!-- 이벤트 처리 시작 -->

<script>

$(document).ready(function () {
  
  var bnoValue = '<c:out value="${board.bno}"/>';
  var replyUL = $(".chat");
  
    showList(1);
    
	function showList(page){
	
		console.log("show list " + page);
    	replyService.getList({bno:bnoValue,page: page|| 1 }, function(list) {
    		
	    	console.log("list: " + list);
	    	var str="";
	
	    	if(list == null || list.length == 0){
	    		replyUL.html("");
	      		return;
	    	}
	
	    	for (var i = 0, len = list.length || 0; i < len; i++) {
	      		str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
	      		str += "  <div>";
	      		str += "      <div class='header'>";
	      		str += "          <strong class='primary-font'>[" + list[i].rno + "] " + list[i].replyer + "</strong>"; 
	      		str += "          <small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate) + "</small>";
	      		str += "      </div>";
	      		str += "      <p>" + list[i].reply + "</p>";
	      		str += "  </div>";
	      		str += "</li>";
	    	}
	
	    	replyUL.html(str);

		});//end function

	}//end showList

    var modal = $(".modal");
    var modalInputReply = modal.find("input[name='reply']");
    var modalInputReplyer = modal.find("input[name='replyer']");
    var modalInputReplyDate = modal.find("input[name='replyDate']");
    
    var modalModBtn = $("#modalModBtn");
    var modalRemoveBtn = $("#modalRemoveBtn");
    var modalRegisterBtn = $("#modalRegisterBtn");
    
    $("#modalCloseBtn").on("click", function(e){
    	
    	modal.modal('hide');
    });
    
    $("#addReplyBtn").on("click", function(e){
      
		modal.find("input").val("");
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id !='modalCloseBtn']").hide();
		modalRegisterBtn.show();
      
		$(".modal").modal("show");
    });
    
	modalRegisterBtn.on("click",function(e){
		
		var reply = {
			reply: modalInputReply.val(),
			replyer:modalInputReplyer.val(),
			bno:bnoValue
		};
		
		replyService.add(reply, function(result){
          
			alert(result);
          
			modal.find("input").val("");
			modal.modal("hide");
          
			showList(1);
        });
    });
	
	//댓글 조회 클릭 이벤트 처리
    $(".chat").on("click", "li", function(e){
      
      var rno = $(this).data("rno");
      
      replyService.get(rno, function(reply){
      
        modalInputReply.val(reply.reply);
        modalInputReplyer.val(reply.replyer);
        modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly","readonly");
        modal.data("rno", reply.rno);
        
        modal.find("button[id !='modalCloseBtn']").hide();
        modalModBtn.show();
        modalRemoveBtn.show();
        
        $(".modal").modal("show");
            
      });
    });
	
	// 댓글 수정 이벤트 처리
	modalModBtn.on("click", function(e){
        
		var reply = {
			rno:modal.data("rno"), 
			reply: modalInputReply.val()
		};
        
		replyService.update(reply, function(result){
              
			alert(result);
			modal.modal("hide");
			showList(1);
        });
      });
	
	// 댓글 삭제 이벤트 처리
    modalRemoveBtn.on("click", function (e){
  	  
    	  var rno = modal.data("rno");
    	  
    	  replyService.remove(rno, function(result){
    	        
    	      alert(result);
    	      modal.modal("hide");
    	      showList(1);
    	      
    	  });
    }); 
	
});

</script>

<!-- 이벤트 처리 끝 -->

<script>
	console.log("===============");
	console.log("JS TEST");
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	/* 댓글 등록 처리 시작 */
	/* 
	// for replyService add test
	replyService.add(
    	{
    		reply:"JS Test", 
    		replyer:"tester", 
    		bno:bnoValue
    	},
	    function(result){
	      alert("RESULT : " + result);
	    }
	);
	 */
	/* 댓글 등록 처리 끝 */

	/* 댓글 목록 처리 시작 */
	/* 
	replyService.getList({bno:bnoValue, page:1}, function(list){
	  for(var i = 0, len = list.length||0; i < len; i++ ){
	    console.log(list[i]);
	  }
	});
	*/
	/* 댓글 목록 처리 끝 */
	
	/* 댓글 15 번 삭제 처리 시작 */
	/* 
	replyService.remove(15, function(count) {

		console.log(count);

		if (count === "success") {
			alert("REMOVED");
		}
	}, function(err) {
		alert('ERROR...');
	});
	 */
	/* 댓글 삭제 처리 끝 */
	
	/* 14번 댓글 수정 처리 시작 */
	/* 
	replyService.update({
		rno : 14,
		bno : bnoValue,
		reply : "댓글 수정 테스트 완료!"
	}, function(result) {
		alert("수정 완료...");
	});  
	 */
	/* 댓글 수정 처리 끝 */
	
	/* 16번 댓글 조회 처리 시작 */
	replyService.get(16, function(data){
		console.log('16번 댓글 조회 : ' + data); 
	});
	/* 댓글 조회 처리 끝 */
</script>

<!-- /#page-wrapper -->
<%@ include file="../includes/footer.jsp"%>