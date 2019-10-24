import java.util.Arrays;

public class MWS {

    public static int indexOf(int[] a, int key) {
        int lo = 0;
        int hi = a.length - 1;
        while (lo <= hi) {
            int mid = lo + (hi - lo) / 2;
            if      (key.compareTo(a[mid]) < 0) hi = mid - 1;
            else if (key.compareTo(a[mid]) > 0) lo = mid + 1;
            else return mid;
        }
        return -1;
    }

    public static void main (String[] args) {

        In listB = new In(args[0]);
        String listF = listB.readAll();
        In wordsB = new In(args[1]);
        String[] words = wordsB.readAllStrings();

        Arrays.sort(words);

        String[] list = listF.split("\\s");
        int part = list.length;
        int cont[] = new int[words.length];

        int wordCounter = 0;
        int pointer1 = 0, pointer2 = 0;
        int fixp1 = 0, fixp2 = 0;
        boolean qualTest = false;

        for (int i=0; i<list.length; i++) {

            int pos = indexOf (list[pointer1], words);
            if (pos != -1) {

                if (cont[pos] == 0) {
                    wordCounter++;
                }
                cont[pos]++;

                if (words.length == wordCounter) {
                    qualTest = true;

                    for (int j = pointer2; j < pointer1; j++) {
                        int pos2 = indexOf (list[pointer2], words-1);

                        if (pos2 != -1){
                            cont[pos2]--;

                            if (cont[pos2] == 0) {

                                wordCounter--;
                                if (pointer1 - pointer2 +1 < part){

                                    part = pointer1 - pointer2 +1;
                                    fixp1 = pointer1;
                                    fixp2 = pointer2;
                                }
                                break;
                            }
                        }
                        pointer2++;
                    }
                }
            }
            pointer1++;
        }

        int flag = 0;
        if (!qualTest) {
            StdOut.print ("Set of words not in text: { ");

            for (int i=0; i < words.length; i++) {

                if (flag == 0) {

                    if (cont[i] == 0) {

                        flag = 1;
                        StdOut.print (" " + words[i]);
                    }
                }
                else
                    StdOut.print (", " + words[i]);
            }
            StdOut.println (" }");
        }
        else{
            StdOut.println ("Number of words in interval: " + part);
            if (args.length > 2){

                for (int i=fixp2; i <= fixp1; i++){

                    if (indexOf(list[i], words, != -1) {
                        list[i] = ("*" + list[i] + "*");
                    }
                    StdOut.print(list[i] + " ");
                }
            }
        }
    }
}