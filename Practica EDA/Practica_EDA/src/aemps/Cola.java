package aemps;

import edalib.list.interfaces.IQueue;
import edalib.list.singlelink.SNode;

public class Cola implements IQueue<Medicamento> {
	private SNode<Medicamento> frontNode;
	private SNode<Medicamento> tailNode;

	public boolean isEmpty() {
		return (frontNode == null);

	}

	public void enqueue(Medicamento elem) {
		SNode<Medicamento> node = new SNode<Medicamento>(elem);
		if (isEmpty()) {
			frontNode = node;
		} else {
			tailNode.nextNode = node;
		}
		tailNode = node;

	}

	public Medicamento dequeue() {
		if (isEmpty()) {
			System.out.println("No hay medicamenots para revisar");
			return null;
		} else {
			Medicamento firstElem = frontNode.getElement();
			frontNode = frontNode.nextNode;
			if (frontNode == null) {
				tailNode = null;
			}
			return firstElem;
		}

	}

	public Medicamento front() {
		if (isEmpty()) {
			System.out.println("No hay medicamenots para revisar");
			return null;
		}
		return frontNode.getElement();
	}

	public int getSize() {
		int size = 0;
		for (SNode<Medicamento> nodeIt = frontNode; nodeIt != null; nodeIt = nodeIt.nextNode) {
			size = size++;
		}
		return size;
	}

	@Override
	public String toString() {
		String result = null;
		for (SNode<Medicamento> nodeIt = frontNode; nodeIt != null; nodeIt = nodeIt.nextNode) {
			if (result == null) {
				result = "[" + nodeIt.getElement().toString() + "]";
			} else {
				result += "," + nodeIt.getElement().toString();
			}
		}
		return result == null ? "empty" : result;
	}

}
