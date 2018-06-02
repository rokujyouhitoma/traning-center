<app>
    <h1>{ title }</h1>
    <dl>
        <items each={ paragraphs } title={ title } text={ text } items={ items } />
    </dl>
    <script>
        this.title = "Ike Tohru"
    	this.paragraphs = [
            { title: "Linkedin", items: [
              { href: "http://www.linkedin.com/pub/tohru-ike/28/4b3/a1b", text: "Tohru Ike"}]},
            { title: "Twitter", items: [
              { href: "https://twitter.com/rokujyouhitoma", text: "@rokujyouhitoma"}]},
            { title: "My friends and I wrote technical book", items: [
              { href: "https://www.amazon.co.jp/gp/product/4774179620", text: "Unreal Engine&Unityエンジニア養成読本[イマドキのゲーム開発最前線! ] (Software Design plus)"},
              { href: "https://www.amazon.co.jp/gp/product/4774152439", text: "JavaScriptテクニックバイブル ~効率的な開発に役立つ150の技"}]},
            { title: "My friends and I wrote web article", items: [
              { href: "http://gihyo.jp/news/report/01/europython2011/0003", text: "そうだ！ EuroPython 2011へ行こう #3 PyPyについての講演，ハンズオン，スプリント"},
              { href: "http://codezine.jp/article/detail/6151", text: "運営スタッフが振り返る「PyCon JP 2011」の模様と今後の展望"},
              { href: "http://codezine.jp/article/detail/6125", text: "「PyCon JP 2011」紹介 番外編～Pythonで働くということ"},
              { href: "http://codezine.jp/article/detail/6118", text: "「PyCon JP 2011」本編以外の注目ポイント～出会いの場をどう活用するか？"}]},
           { title: "Community", items: [
              { href: "https://groups.google.com/forum/?fromgroups#!forum/pypy-ja", text: "pypy-ja"},
              { href: "http://java-ja.yoshiori.org/", text: "java-ja"},
              { href: "", text: "Python温泉系"},
              { href: "http://www.city.imari.saga.jp/9718.htm", text: "松浦党研究連合会"},
              { href: "", text: "若手IT勉強会"}]}
        ]
    </script>
</app>