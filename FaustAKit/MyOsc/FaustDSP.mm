/* ------------------------------------------------------------
name: "MyOsc"
Code generated with Faust 2.41.1 (https://faust.grame.fr)
Compilation options: -a /Users/yoogle/Faust-2.41.1/share/faust/audiokit/FaustDSP.mm -lang cpp -cn MyOsc -es 1 -mcd 16 -uim -single -ftz 0
------------------------------------------------------------ */

#ifndef  __MyOsc_H__
#define  __MyOsc_H__

/************************************************************************
 
 IMPORTANT NOTE : this file contains two clearly delimited sections :
 the ARCHITECTURE section (in two parts) and the USER section. Each section
 is governed by its own copyright and license. Please check individually
 each section for license and copyright information.
 *************************************************************************/

/******************* BEGIN FaustDSP.mm ****************/
/************************************************************************
 FAUST Architecture File
 Copyright (C) 2004-2021 GRAME, Centre National de Creation Musicale
 ---------------------------------------------------------------------
 This Architecture section is free software; you can redistribute it
 and/or modify it under the terms of the GNU Lesser General Public
 License as published by the Free Software Foundation; either version 3
 of the License, or (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU Lesser General Public License for more details.
 
 You should have received a copy of the GNU Lesser General Public License
 along with this program; If not, see <http://www.gnu.org/licenses/>.
 
 EXCEPTION : As a special exception, you may create a larger work
 that contains this FAUST architecture section and distribute
 that work under terms of your choice, so long as this FAUST
 architecture section is not modified.
 
 ************************************************************************
 ************************************************************************/

#import "DSPBase.h"
#import <algorithm>
#import <vector>
#import <assert.h>

#include "faust/dsp/dsp.h"
#include "faust/misc.h"
#include "faust/gui/DecoratorUI.h"

#ifdef MIDICTRL
#include "faust/gui/MidiUI.h"
#endif

#ifdef POLY
#include "faust/dsp/poly-dsp.h"
#endif

#define FAUST_UIMACROS 1

// but we will ignore most of them
#define FAUST_ADDBUTTON(l,f)
#define FAUST_ADDCHECKBOX(l,f)
#define FAUST_ADDVERTICALSLIDER(l,f,i,a,b,s)
#define FAUST_ADDHORIZONTALSLIDER(l,f,i,a,b,s)
#define FAUST_ADDNUMENTRY(l,f,i,a,b,s)
#define FAUST_ADDVERTICALBARGRAPH(l,f,a,b)
#define FAUST_ADDHORIZONTALBARGRAPH(l,f,a,b)

#ifndef FAUSTFLOAT
#define FAUSTFLOAT float
#endif 

#include <algorithm>
#include <cmath>
#include <cstdint>
#include <math.h>

#ifndef FAUSTCLASS 
#define FAUSTCLASS MyOsc
#endif

#ifdef __APPLE__ 
#define exp10f __exp10f
#define exp10 __exp10
#endif

#if defined(_WIN32)
#define RESTRICT __restrict
#else
#define RESTRICT __restrict__
#endif


class MyOsc : public dsp {
	
 public:
	
	int fSampleRate;
	float fConst0;
	float fConst1;
	FAUSTFLOAT fEntry0;
	float fConst2;
	float fRec0[2];
	FAUSTFLOAT fEntry1;
	float fRec1[2];
	float fConst3;
	FAUSTFLOAT fEntry2;
	float fRec4[2];
	float fRec2[2];
	
 public:
	
	void metadata(Meta* m) { 
		m->declare("compile_options", "-a /Users/yoogle/Faust-2.41.1/share/faust/audiokit/FaustDSP.mm -lang cpp -cn MyOsc -es 1 -mcd 16 -uim -single -ftz 0");
		m->declare("filename", "MyOsc.dsp");
		m->declare("maths.lib/author", "GRAME");
		m->declare("maths.lib/copyright", "GRAME");
		m->declare("maths.lib/license", "LGPL with exception");
		m->declare("maths.lib/name", "Faust Math Library");
		m->declare("maths.lib/version", "2.5");
		m->declare("name", "MyOsc");
		m->declare("oscillators.lib/name", "Faust Oscillator Library");
		m->declare("oscillators.lib/version", "0.3");
		m->declare("platform.lib/name", "Generic Platform Library");
		m->declare("platform.lib/version", "0.2");
		m->declare("signals.lib/name", "Faust Signal Routing Library");
		m->declare("signals.lib/version", "0.3");
	}

	virtual int getNumInputs() {
		return 0;
	}
	virtual int getNumOutputs() {
		return 2;
	}
	
	static void classInit(int sample_rate) {
	}
	
	virtual void instanceConstants(int sample_rate) {
		fSampleRate = sample_rate;
		fConst0 = std::min<float>(192000.0f, std::max<float>(1.0f, float(fSampleRate)));
		fConst1 = 44.0999985f / fConst0;
		fConst2 = 1.0f - fConst1;
		fConst3 = 1.0f / fConst0;
	}
	
	virtual void instanceResetUserInterface() {
		fEntry0 = FAUSTFLOAT(1.0f);
		fEntry1 = FAUSTFLOAT(1.0f);
		fEntry2 = FAUSTFLOAT(440.0f);
	}
	
	virtual void instanceClear() {
		for (int l0 = 0; l0 < 2; l0 = l0 + 1) {
			fRec0[l0] = 0.0f;
		}
		for (int l1 = 0; l1 < 2; l1 = l1 + 1) {
			fRec1[l1] = 0.0f;
		}
		for (int l2 = 0; l2 < 2; l2 = l2 + 1) {
			fRec4[l2] = 0.0f;
		}
		for (int l3 = 0; l3 < 2; l3 = l3 + 1) {
			fRec2[l3] = 0.0f;
		}
	}
	
	virtual void init(int sample_rate) {
		classInit(sample_rate);
		instanceInit(sample_rate);
	}
	virtual void instanceInit(int sample_rate) {
		instanceConstants(sample_rate);
		instanceResetUserInterface();
		instanceClear();
	}
	
	virtual MyOsc* clone() {
		return new MyOsc();
	}
	
	virtual int getSampleRate() {
		return fSampleRate;
	}
	
	virtual void buildUserInterface(UI* ui_interface) {
		ui_interface->openVerticalBox("MyOsc");
		ui_interface->addNumEntry("freq", &fEntry2, FAUSTFLOAT(440.0f), FAUSTFLOAT(20.0f), FAUSTFLOAT(20000.0f), FAUSTFLOAT(0.00999999978f));
		ui_interface->addNumEntry("gain", &fEntry0, FAUSTFLOAT(1.0f), FAUSTFLOAT(0.0f), FAUSTFLOAT(1.0f), FAUSTFLOAT(0.00999999978f));
		ui_interface->addNumEntry("gate", &fEntry1, FAUSTFLOAT(1.0f), FAUSTFLOAT(0.0f), FAUSTFLOAT(1.0f), FAUSTFLOAT(1.0f));
		ui_interface->closeBox();
	}
	
	virtual void compute(int count, FAUSTFLOAT** RESTRICT inputs, FAUSTFLOAT** RESTRICT outputs) {
		FAUSTFLOAT* output0 = outputs[0];
		FAUSTFLOAT* output1 = outputs[1];
		float fSlow0 = fConst1 * float(fEntry0);
		float fSlow1 = fConst1 * float(fEntry1);
		float fSlow2 = fConst1 * float(fEntry2);
		for (int i0 = 0; i0 < count; i0 = i0 + 1) {
			fRec0[0] = fSlow0 + fConst2 * fRec0[1];
			fRec1[0] = fSlow1 + fConst2 * fRec1[1];
			fRec4[0] = fSlow2 + fConst2 * fRec4[1];
			float fTemp0 = std::max<float>(1.1920929e-07f, std::fabs(fRec4[0]));
			float fTemp1 = fRec2[1] + fConst3 * fTemp0;
			float fTemp2 = fTemp1 + -1.0f;
			int iTemp3 = fTemp2 < 0.0f;
			fRec2[0] = ((iTemp3) ? fTemp1 : fTemp2);
			float fThen1 = fTemp1 + (1.0f - fConst0 / fTemp0) * fTemp2;
			float fRec3 = ((iTemp3) ? fTemp1 : fThen1);
			float fTemp4 = fRec0[0] * fRec1[0] * (2.0f * fRec3 + -1.0f);
			output0[i0] = FAUSTFLOAT(fTemp4);
			output1[i0] = FAUSTFLOAT(fTemp4);
			fRec0[1] = fRec0[0];
			fRec1[1] = fRec1[0];
			fRec4[1] = fRec4[0];
			fRec2[1] = fRec2[0];
		}
	}

};

#ifdef FAUST_UIMACROS
	
	#define FAUST_FILE_NAME "MyOsc.dsp"
	#define FAUST_CLASS_NAME "MyOsc"
	#define FAUST_COMPILATION_OPIONS "-a /Users/yoogle/Faust-2.41.1/share/faust/audiokit/FaustDSP.mm -lang cpp -cn MyOsc -es 1 -mcd 16 -uim -single -ftz 0"
	#define FAUST_INPUTS 0
	#define FAUST_OUTPUTS 2
	#define FAUST_ACTIVES 3
	#define FAUST_PASSIVES 0

	FAUST_ADDNUMENTRY("freq", fEntry2, 440.0f, 20.0f, 20000.0f, 0.01f);
	FAUST_ADDNUMENTRY("gain", fEntry0, 1.0f, 0.0f, 1.0f, 0.01f);
	FAUST_ADDNUMENTRY("gate", fEntry1, 1.0f, 0.0f, 1.0f, 1.0f);

	#define FAUST_LIST_ACTIVES(p) \
		p(NUMENTRY, freq, "freq", fEntry2, 440.0f, 20.0f, 20000.0f, 0.01f) \
		p(NUMENTRY, gain, "gain", fEntry0, 1.0f, 0.0f, 1.0f, 0.01f) \
		p(NUMENTRY, gate, "gate", fEntry1, 1.0f, 0.0f, 1.0f, 1.0f) \

	#define FAUST_LIST_PASSIVES(p) \

#endif

class FaustMyOsc : public DSPBase, public GenericUI {
    
    private:
        MyOsc* fDSP;
        size_t inputChannelCount = 0;
        size_t outputChannelCount = 0;
        std::vector<FAUSTFLOAT*> fZones;
    #ifdef MIDICTRL
        midi_handler fMidiHandler;
        MidiUI fMidiUI;
    #endif
    
        // -- active widgets
        void addButton(const char* label, FAUSTFLOAT* zone) override { fZones.push_back(zone); }
        void addCheckButton(const char* label, FAUSTFLOAT* zone) override { fZones.push_back(zone); }
        void addVerticalSlider(const char*
                               label,
                               FAUSTFLOAT* zone,
                               FAUSTFLOAT init,
                               FAUSTFLOAT min,
                               FAUSTFLOAT max,
                               FAUSTFLOAT step) override
        {
            fZones.push_back(zone);
        }
        void addHorizontalSlider(const char*
                                 label,
                                 FAUSTFLOAT* zone,
                                 FAUSTFLOAT init,
                                 FAUSTFLOAT min,
                                 FAUSTFLOAT max,
                                 FAUSTFLOAT step) override
        {
            fZones.push_back(zone);
        }
        void addNumEntry(const char*
                         label,
                         FAUSTFLOAT* zone,
                         FAUSTFLOAT init,
                         FAUSTFLOAT min,
                         FAUSTFLOAT max,
                         FAUSTFLOAT step) override
        {
            fZones.push_back(zone);
        }
    
        // -- passive widgets
        void addHorizontalBargraph(const char* label, FAUSTFLOAT* zone, FAUSTFLOAT min, FAUSTFLOAT max) override {}
        void addVerticalBargraph(const char* label, FAUSTFLOAT* zone, FAUSTFLOAT min, FAUSTFLOAT max) override {}
    
    public:
    
    #ifdef MIDICTRL
        FaustMyOsc():fMidiUI(&fMidiHandler)
    #else
        FaustMyOsc()
    #endif
        {
        #ifdef POLY
            int nvoices = 0;
            bool midi_sync = false;
            fDSP = new MyOsc();
            MidiMeta::analyse(DSP, midi_sync, nvoices);
            fDSP = new MyOsc_poly(DSP, nvoices, true, true);
        #else
            fDSP = new MyOsc();
        #endif
            inputChannelCount = fDSP->getNumInputs();
            outputChannelCount = fDSP->getNumOutputs();
        #ifdef MIDICTRL
            fDSP->buildUserInterface(&fMidiUI);
        #endif
            fDSP->buildUserInterface(this);
            //assert(fDSP->getNumInputs() == (fDSP->getNumOutputs()));
        }
    
        ~FaustMyOsc()
        {
            delete fDSP;
        }
    
        void setParameter(AUParameterAddress address, float value, bool immediate) override
        {
             if (address < fZones.size()) {
                *fZones[address] = value;
             }
        }
    
        void init(int channelCount, double sampleRate) override
        {
            fDSP->init(int(sampleRate));
        }
    
        void reset() override
        {
            fDSP->instanceResetUserInterface();
            fDSP->instanceClear();
        }
    
    #ifdef MIDICTRL
        void handleMIDIEvent(AUMIDIEvent const& ev) override
        {
            if (ev.length == 1) {
                fMidiHandler.handleData1(ev.eventSampleTime, ev.eventType, ev.data[0]);
            } else if (ev.length == 2) {
                fMidiHandler.handleData2(ev.eventSampleTime, ev.eventType, ev.data[0], ev.data[1]);
            }
        }
    #endif
    
        void startRamp(const AUParameterEvent &event) override
        {
            auto address = event.parameterAddress;
            if (address < fZones.size()) {
                *fZones[address] = event.value;
            }
        }
    
        // Need to override this since it's pure virtual.
        void process(AUAudioFrameCount frameCount, AUAudioFrameCount bufferOffset) override
        {
            float* inputs[inputChannelCount];
            float* outputs[outputChannelCount];

            for (int channel = 0; channel < inputChannelCount; ++channel) {
                inputs[channel] = (float*)inputBufferLists[0]->mBuffers[channel].mData + bufferOffset;
            }
            for (int channel = 0; channel < outputChannelCount; ++channel) {
                outputs[channel] = (float*)outputBufferList->mBuffers[channel].mData + bufferOffset;
            }
            fDSP->compute(int(frameCount), inputs, outputs);
        }
    
};

// Register AK class and parameters

enum MyOscParameter : AUParameterAddress {
#define ACTIVE_ENUM_MEMBER(type, ident, name, var, def, min, max, step) \
MyOsc_##ident,
    FAUST_LIST_ACTIVES(ACTIVE_ENUM_MEMBER)
    kNumActives,
};

AK_REGISTER_DSP(FaustMyOsc)

#define REGISTER_PARAMETER(type, ident, name, var, def, min, max, step) \
    AK_REGISTER_PARAMETER(MyOsc_##ident)
FAUST_LIST_ACTIVES(REGISTER_PARAMETER);

/******************* END FaustDSP.mm ****************/

#endif
