class RevView implements Iterable<T>{
	private T[] array;

	public RevView (T[] array){
		this.array = array;
	}

	@Override 
	public Iterator<T> iterator(){
		return new Iterator<T>(){
			private int crtIndex = array.length-1;

			@Override
			public boolean hasNext(){
				return crtIndex >= 0;
			}

			@Override
			public T next(){
				return array[crtIndex--];
			}
		};
	}
}


class View {
	public static void main (String[] args){
		Integer[] v = new Integer[] {1,2,3};

		/*
		RevView<Integer> r = new RevView<Integer>(v);
		Iterator<Integer> it = r.iterator();
		*/
		Iterator<Integer> it = (new RevView<Integer>(v)).iterator();

		while (it.hasNext()){
			System.out.println(it.next());
		}

	}
}