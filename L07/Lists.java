import java.util.Iterator;
/*
	When designing an interface, we need to design the operations first!
*/
interface List<E> extends Iterable<E>{
	public E head();
	public List<E> tail();
	public List<E> append(List<E> l);
	public Integer size();
	public List<E> reverse();
	public Iterator<E> iterator();
}

/* Next, we design the constructors 
*/

class Void<E> implements List<E> {
	public Void(){}

	@Override
	public E head() {return null;}
	@Override
	public List<E> tail() {return null;}
	@Override
	public List<E> append(List<E> l){
		return l;
	}
	@Override
	public Integer size(){ 
		return 0;
	}

	@Override
	public List<E> reverse(){
		return this;
	}
	@Override
	public String toString(){return "[]";}

	@Override
	public Iterator<E> iterator(){
		return new Iterator(){
			@Override 
			public boolean hasNext(){return false;}
			@Override
			public E next(){return null;}
		};
	}

}

class Cons<E> implements List<E> {
	private E value;
	private List<E> next;

	public Cons(E value, List<E> next){
		this.value = value;
		this.next = next;
	}

	@Override
	public E head() {return value;}
	@Override
	public List<E> tail() {return next;}
	@Override
	public List<E> append(List<E> l){
		return new Cons<E>(value,next.append(l));
	}
	@Override
	public Integer size(){ 
		return 1 + next.size();
	}
	@Override
	public List<E> reverse(){
		return next.reverse().append(new Cons<E>(value,new Void()));
	}
	@Override
	public String toString(){return value.toString()+":"+next.toString();}

	@Override
	public Iterator<E> iterator(){
		return new Iterator(){
			List<E> crt = Cons.this;
			@Override 
			public boolean hasNext(){return crt instanceof Cons;}
			@Override
			public E next(){ 
				E val = (E)((Cons)crt).value;
				crt = ((Cons)crt).next; 
				return val;}
		};
	}

}


public class Lists {
	public static void main(String[] args){
		List<Integer> l = new Cons(1,new Cons(2, new Cons(3, new Void())));
		System.out.println(l.reverse());

		for (Integer i:l){
			System.out.println(i);
		}

	}
}