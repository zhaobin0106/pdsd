<?php
class show_article
{
	public function index()
	{
		$id = intval ( $GLOBALS ['request'] ['id'] );
		$sql = "select id, title, content, create_time from " . DB_PREFIX . "article where is_effect = 1 and is_delete = 0 and id =" . $id;
		$article = $GLOBALS ['db']->getRow ( $sql );
		
		$root = array ();
		$root ['id'] = $article ['id'];
		$root ['title'] = $article ['title'];
		$root ['create_time'] = to_date ( $article ['create_time'] );
		$root ['content'] = $article ['content'];
		$root ['response_code'] = 1;
		output ( $root );
	}
}

?>