package jdk.bug8189938;

import java.awt.FlowLayout;

import javax.swing.JButton;
import javax.swing.JComponent;
import javax.swing.JFileChooser;
import javax.swing.JFrame;
import javax.swing.SwingUtilities;

public class Main {

	public static void main(String[] args) {
		SwingUtilities.invokeLater(() -> {
			JFrame frame = new JFrame("JDK-8189938");
			frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

			JComponent c = (JComponent) frame.getContentPane();
			c.setLayout(new FlowLayout());

			JButton b = new JButton("Select File");
			b.addActionListener(evt -> {
				JFileChooser jfc = new JFileChooser();
				jfc.showOpenDialog(b);
				System.out.println(jfc.getSelectedFile());
			});

			c.add(b);
			frame.pack();
			frame.setVisible(true);
		});
	}

}
