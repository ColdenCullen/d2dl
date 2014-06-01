var Explorer = Class.create();

Explorer.prototype = {
	explorerDOM: null,
	contentDOM: null,
	
	initialize: function(explorerDOM,contentDOM){
		this.explorerDOM = explorerDOM;
		this.contentDOM = contentDOM;
	},
	
	addModule: function(moduleName){
		var a = document.createElement("A");
		a.href='#';
		a.title=moduleName;
		a.onclick = function(){
			var url = moduleName.replace(/\./g,"/") + ".html";
			new Ajax.Request(
				url,
				{
					method: "get",
					onComplete: function(obj){
						try{
						this.loadModuleDocument(obj.responseText);
					}
					catch(e){ console.debug(e); }
					}.bind(this)
				}
			);
			
		}.bind(this);
		a.innerHTML = moduleName;
		
		this.explorerDOM.appendChild(a);
		this.explorerDOM.appendChild(document.createElement("BR"));
	},
	
	loadModuleDocument: function(content){
		// create HTML DOM objects from markup
		var temp = document.createElement("DIV");
		temp.innerHTML = content;
		
		// tear apart the temporary "document", and feed the results back into the page
		console.debug(temp);
		if(this.contentDOM.firstChild){
			this.contentDOM.replaceChild(temp,this.contentDOM.firstChild);
		}
		else{
			this.contentDOM.appendChild(temp);
		}
	},
	
	$: function(node) {
		var elements = new Array();
		
		for (var i = 1; i < arguments.length; i++) {
			var element = arguments[i];
			if (typeof element == 'string'){
			    if(node.getAttribute("id") == element){
				    elements.push(node);
				    continue;
			    }
			    
			    $A(node.childNodes).each(function(child){
				    var args = arguments;
				    args[0] = child;
				    elements.concat(this.$.apply(this,args)); // recurse
			    });
			}
		}
	    if (arguments.length == 1) return element;
		return elements;
	}	
};