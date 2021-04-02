
interface Formula {
	//public Integer depth();
	public boolean isCNF();
	public boolean isAtom();
	public boolean isLiteral();
	public boolean isClause();
}


class Atom implements Formula {
	private String name;
	public Atom(String name){
		this.name = name;
	}
	@Override 
	public boolean isCNF() {return true;}
	@Override 
	public boolean isAtom() {return true;}
	@Override 
	public boolean isLiteral() {return true;}
	@Override
	public boolean isClause() {return true;}

}

class Not implements Formula{
	private Formula f;
	public Not(Formula f){
		this.f = f;
	}
	@Override 
	public boolean isCNF() {return f.isAtom();}
	@Override 
	public boolean isAtom() {return false;}
	@Override 
	public boolean isLiteral() {return f.isAtom();}
	@Override
	public boolean isClause() {return f.isAtom();}
}

class Or implements Formula{
	private List<Formula> fl;
	public Or(List<Formula> fl){
		this.fl = fl;
	}
	@Override 
	public boolean isCNF() {
		return isClause();
	}
	@Override 
	public boolean isAtom() {return false;}
	@Override 
	public boolean isLiteral() {return false;}
	@Override
	public boolean isClause() {
		for (Formula f:fl){
			if (!f.isLiteral())
				return false;
		}
		return true;
	}
}

class And implements Formula{
	private List<Formula> fl;
	public And(List<Formula> fl){
		this.fl = fl;
	}
	@Override 
	public boolean isCNF() {
		for (Formula f:fl){
			if(!f.isClause())
				return false;
		}
		return true;
	}
	@Override 
	public boolean isAtom() {return false;}
	@Override 
	public boolean isLiteral() {return false;}
	@Override
	public boolean isClause() {
		return false;
	}
}


public class Formulae {
	public static <E> List<E> fromArray(E[] arr) {
		
		List<E> crt = new Void();
		for (int i = arr.length-1; i>= 0 ; i--){
			crt = new Cons(arr[i],crt);
		}
		return crt;
	} 
	public static void main(String[] args){
		Formula f1 = new Or(new Cons(new Not(new Atom("a")), new Cons(new Atom("b"),new Void())));

		Formula f2 = new And(fromArray(new Formula[]{
			new Or(fromArray(new Formula[]{new Atom("a"), new Not(new Atom("b"))})),
			new Or(fromArray(new Formula[]{new Atom("a"), new Atom("b")})),
			new Not(new Atom("b"))
		}));

		System.out.println(f2.isCNF());


	}
}